#include "stdafx.h"
#include "ast.h"

/// Annotation ///////////////////////////////////////////////////////////

namespace comp
{
    template <typename It>
    struct annotation
    {
        template <typename>
        struct result { typedef void type; };

        std::vector<It>& iters;

        annotation(std::vector<It>& iters)
            : iters(iters) 
        {}

        struct set_id
        {
            typedef void result_type;

            int id;
            set_id(int id) : id(id) {}

            void operator()(ast::function_call& x) const
            {
                x.function_name.id = id;
            }

            void operator()(ast::identifier& x) const
            {
                x.id = id;
            }

            template <typename T>
            void operator()(T& x) const
            {
                // no-op
            }
        };

        void operator()(ast::operand& ast, It pos) const
        {
            int id = iters.size();
            iters.push_back(pos);
            boost::apply_visitor(set_id(id), ast);
        }

        void operator()(ast::variable_declaration& ast, It pos) const
        {
            int id = iters.size();
            iters.push_back(pos);
            ast.lhs.id = id;
        }

        void operator()(ast::assignment& ast, It pos) const
        {
            int id = iters.size();
            iters.push_back(pos);
            ast.lhs.id = id;
        }

        void operator()(ast::return_statement& ast, It pos) const
        {
            int id = iters.size();
            iters.push_back(pos);
            ast.id = id;
        }

        void operator()(ast::identifier& ast, It pos) const
        {
            int id = iters.size();
            iters.push_back(pos);
            ast.id = id;
        }
    };
}

/// White space //////////////////////////////////////////////////////////

namespace comp
{
    template <typename It>
    struct white_space: qi::grammar<It>
    {
        white_space()
            : white_space::base_type(start)
        {
            qi::char_type char_;
            ascii::space_type space;
            using boost::spirit::eol;

            start =
                space                               // tab/space/cr/lf
                | ("/*" >> *(char_ - "*/") >> "*/") // C-style comments
                | ("//" >> *(char_ - eol) >> eol)   // C++ style comments 
                ;
        }

        qi::rule<It> start;
    };
}

/// Error handler ////////////////////////////////////////////////////////

namespace comp
{
    template <typename It>
    struct error_handler
    {
        template <typename>
        struct result { typedef void type; };

        error_handler(It f, It l)
            : linenum(1)
            , first(f)
            , last(l) 
            , iters()
        {}

        template <typename Message, typename What>
        void operator()(Message const& message, What const& what, It err_pos) const
        {
            int line;
            It line_start = get_pos(err_pos, line);

            std::ostringstream err;

            if (err_pos != last)
            {
                err << message << what << " line " << line << ':' << std::endl;
                err << get_line(line_start) << std::endl;

                for (; line_start != err_pos; ++line_start)
                    err << ' ';

                err << '^' << std::endl;
            }
            else
            {
                err << "Unexpected end of file. ";
                err << message << what << " line " << line << std::endl;
            }

            linenum = line;
            throw std::logic_error(err.str());
        }

        It get_pos(It err_pos, int& line) const
        {
            line = 1;
            It i = first;
            It line_start = first;
            while (i != err_pos)
            {
                bool eol = false;
                if (i != err_pos && *i == '\r') // CR
                {
                    eol = true;
                    line_start = ++i;
                }
                if (i != err_pos && *i == '\n') // LF
                {
                    eol = true;
                    line_start = ++i;
                }
                if (eol)
                    ++line;
                else
                    ++i;
            }

            return line_start;
        }

        std::string get_line(It err_pos) const
        {
            It i = err_pos;

            // position i to the next EOL
            while (i != last && (*i != '\r' && *i != '\n'))
                ++i;

            return std::string(err_pos, i);
        }

        mutable unsigned linenum;
        It first;
        It last;
        std::vector<It> iters;
    };
}

/// Expression ///////////////////////////////////////////////////////////

namespace comp
{
    template <typename It>
    struct expression: qi::grammar<It, ast::expression(), white_space<It> >
    {
        expression(error_handler<It>& error_handler);

        qi::rule<It, ast::expression(), white_space<It> >
            expr, equality_expr, relational_expr,
            logical_or_expr, logical_and_expr,
            additive_expr, multiplicative_expr
            ;

        qi::rule<It, ast::operand(), white_space<It> >
            unary_expr, primary_expr
            ;

        qi::rule<It, ast::function_call(), white_space<It> >
            function_call
            ;

        qi::rule<It, std::list<ast::expression>(), white_space<It> >
            argument_list
            ;

        qi::rule<It, std::string(), white_space<It> >
            identifier
            ;

        qi::symbols<char, ast::optoken>
            logical_or_op, logical_and_op,
            equality_op, relational_op,
            additive_op, multiplicative_op, unary_op
            ;

        qi::symbols<char>
            keywords
            ;
    };
}

/// Statement ////////////////////////////////////////////////////////////

namespace comp
{
    template <typename It>
    struct statement: qi::grammar<It, ast::statement_list(), white_space<It> >
    {
        statement(error_handler<It>& error_handler);

        expression<It> expr;

        qi::rule<It> empty_statement;
        qi::rule<It, ast::statement_list(), white_space<It> > statement_list, compound_statement;
        qi::rule<It, ast::statement(), white_space<It> > statement_;
        qi::rule<It, ast::variable_declaration(), white_space<It> > variable_declaration;
        qi::rule<It, ast::assignment(), white_space<It> > assignment;
        qi::rule<It, ast::if_statement(), white_space<It> > if_statement;
        qi::rule<It, ast::while_statement(), white_space<It> > while_statement;
        qi::rule<It, ast::return_statement(), white_space<It> > return_statement;
        qi::rule<It, std::string(), white_space<It> > identifier;
    };

}

/// Function /////////////////////////////////////////////////////////////

namespace comp
{
    template <typename It>
    struct func: qi::grammar<It, ast::function(), white_space<It> >
    {
        func(error_handler<It>& error_handler);

        statement<It> body;
        qi::rule<It, std::string(), white_space<It> > name;
        qi::rule<It, ast::identifier(), white_space<It> > identifier;
        qi::rule<It, std::list<ast::identifier>(), white_space<It> > argument_list;
        qi::rule<It, ast::function(), white_space<It> > start;
    };
}

/// Constructors /////////////////////////////////////////////////////////

namespace comp
{
    template <typename It>
    statement<It>::statement(error_handler<It>& error_handler)
        : statement::base_type(statement_list)
        , expr(error_handler)
    {
        qi::_1_type _1;
        qi::_2_type _2;
        qi::_3_type _3;
        qi::_4_type _4;

        qi::_val_type _val;
        qi::raw_type raw;
        qi::lexeme_type lexeme;
        qi::alpha_type alpha;
        qi::alnum_type alnum;
        qi::lit_type lit;
        qi::char_type char_;
        ascii::space_type space;

        using qi::on_error;
        using qi::on_success;
        using qi::fail;
        using boost::phoenix::function;
        using boost::spirit::eol;

        typedef function<comp::error_handler<It> > error_handler_function;
        typedef function<comp::annotation<It> > annotation_function;

        statement_list =
             *statement_
             //| -empty_statement
            ;

        statement_ = 
              variable_declaration
            | assignment          
            | compound_statement  
            | if_statement        
            | while_statement     
            | return_statement    
            | empty_statement
            ;

        empty_statement = 
              space
            | ("/*" >> *(char_ - "*/") >> "*/") // C-style comments
            | ("//" >> *(char_ - eol) >> eol)   // C++ style comments 
            | (";" >> eol)                      // empty statement
            ;

        identifier =
               !expr.keywords
            >> raw[lexeme[(alpha | '_') >> *(alnum | '_')]]
            ;

        variable_declaration =
              lexeme["int" >> !(alnum | '_')]
            > identifier
            > -('=' > expr)
            > ';'
            ;

        assignment =
              identifier
            > '='
            > expr
            > ';'
            ;

        if_statement =
              lit("if")
            > '('
            > expr
            > ')'
            > statement_
            >
               -(
                    lexeme["else" >> !(alnum | '_')] // make sure we have whole words
                >   statement_
                )
            ;

        while_statement =
              lit("while")
            > '('
            > expr
            > ')'
            > statement_
            ;

        compound_statement =
            '{' >> -statement_list >> '}'
            ;

        return_statement =
                lexeme["return" >> !(alnum | '_')] 
            >  -expr
            >   ';'
            ;

        BOOST_SPIRIT_DEBUG_NODES(
            (statement_list)
            (identifier)
            (variable_declaration)
            (assignment)
        );

        on_error<fail>(statement_list, error_handler_function(error_handler)("Error! Expecting ", _4, _3));

        on_success(variable_declaration, annotation_function(error_handler.iters)(_val, _1));
        on_success(assignment, annotation_function(error_handler.iters)(_val, _1));
        on_success(return_statement, annotation_function(error_handler.iters)(_val, _1));
    }

    template <typename It>
    expression<It>::expression(error_handler<It>& error_handler)
      : expression::base_type(expr)
    {
        qi::_1_type _1;
        qi::_2_type _2;
        qi::_3_type _3;
        qi::_4_type _4;

        qi::char_type char_;
        qi::uint_type uint_;
        qi::_val_type _val;
        qi::raw_type raw;
        qi::lexeme_type lexeme;
        qi::alpha_type alpha;
        qi::alnum_type alnum;
        qi::bool_type bool_;

        using qi::on_error;
        using qi::on_success;
        using qi::fail;
        using boost::phoenix::function;

        typedef function<comp::error_handler<It> > error_handler_function;
        typedef function<comp::annotation<It> > annotation_function;

        ///////////////////////////////////////////////////////////////////////
        // Tokens
        logical_or_op.add
            ("||", ast::op_or)
            ;

        logical_and_op.add
            ("&&", ast::op_and)
            ;

        equality_op.add
            ("==", ast::op_equal)
            ("!=", ast::op_not_equal)
            ;

        relational_op.add
            ("<", ast::op_less)
            ("<=", ast::op_less_equal)
            (">", ast::op_greater)
            (">=", ast::op_greater_equal)
            ;

        additive_op.add
            ("+", ast::op_plus)
            ("-", ast::op_minus)
            ;

        multiplicative_op.add
            ("*", ast::op_times)
            ("/", ast::op_divide)
            ;

        unary_op.add
            ("+", ast::op_positive)
            ("-", ast::op_negative)
            ("!", ast::op_not)
            ;

        keywords.add
            ("true")
            ("false")
            ("if")
            ("else")
            ("while")
            ("int")
            ("long")
            ("decimal")
            ("float")
            ("double")
            ("void")
            ("return")
            ;

        expr =
            logical_or_expr.alias()
            ;

        logical_or_expr =
                logical_and_expr
            >> *(logical_or_op > logical_and_expr)
            ;

        logical_and_expr =
                equality_expr
            >> *(logical_and_op > equality_expr)
            ;

        equality_expr =
                relational_expr
            >> *(equality_op > relational_expr)
            ;

        relational_expr =
                additive_expr
            >> *(relational_op > additive_expr)
            ;

        additive_expr =
                multiplicative_expr
            >> *(additive_op > multiplicative_expr)
            ;

        multiplicative_expr =
                unary_expr
            >> *(multiplicative_op > unary_expr)
            ;

        unary_expr =
                primary_expr
            |   (unary_op > unary_expr)
            ;

        primary_expr =
                uint_
            |   function_call
            |   identifier
            |   bool_
            |   '(' > expr > ')'
            ;

        function_call =
                (identifier >> '(')
            >   argument_list
            >   ')'
            ;

        argument_list = -(expr % ',');

        identifier =
                !lexeme[keywords >> !(alnum | '_')]
            >>  raw[lexeme[(alpha | '_') >> *(alnum | '_')]]
            ;

        BOOST_SPIRIT_DEBUG_NODES(
            (expr)
            (logical_or_expr)
            (logical_and_expr)
            (equality_expr)
            (relational_expr)
            (additive_expr)
            (multiplicative_expr)
            (unary_expr)
            (primary_expr)
            (function_call)
            (argument_list)
            (identifier)
        );

        on_error<fail>(expr, error_handler_function(error_handler)("Error! Expecting ", _4, _3));
        on_success(primary_expr, annotation_function(error_handler.iters)(_val, _1));
    }

    template <typename It>
    func<It>::func(error_handler<It>& error_handler)
      : func<It>::base_type(start)
      , body(error_handler)
    {
        qi::_1_type _1;
        qi::_2_type _2;
        qi::_3_type _3;
        qi::_4_type _4;

        qi::_val_type _val;
        qi::raw_type raw;
        qi::lexeme_type lexeme;
        qi::alpha_type alpha;
        qi::alnum_type alnum;
        qi::string_type string;

        using qi::on_error;
        using qi::on_success;
        using qi::fail;
        using boost::phoenix::function;

        typedef function<comp::error_handler<It> > error_handler_function;
        typedef function<comp::annotation<It> > annotation_function;

        name =
                !body.expr.keywords
            >>  raw[lexeme[(alpha | '_') >> *(alnum | '_')]]
            ;

        identifier = name;
        argument_list = -(identifier % ',');

        start =
                lexeme[(string("void") | string("int") | string("money"))
                    >> !(alnum | '_')]  // make sure we have whole words
            >   identifier
            >   '(' > argument_list > ')'
            >   '{' > body > '}'
            ;

        BOOST_SPIRIT_DEBUG_NODES(
            (identifier)
            (argument_list)
            (start)
        );

        on_error<fail>(start, error_handler_function(error_handler)("Error! Expecting ", _4, _3));

        on_success(identifier, annotation_function(error_handler.iters)(_val, _1));
    }
}

/// Main /////////////////////////////////////////////////////////////////

#include "../afx/afx.hxx"
#include "compiler0.h"
#include "vm.h"

int main(int argc, char const* argv[])
{
    typedef std::string str_t;
    typedef std::string::const_iterator iter_t;

    std::string input_filename = "test.script";

    try
    {
        str_t input = read_text<char>(input_filename);
        iter_t iter = input.begin();
        iter_t end = input.end();

        comp::error_handler<iter_t> eh(iter, end);

        try
        {
            comp::func<iter_t> fn(eh);
            comp::white_space<iter_t> ws;

            comp::ast::function_list ast;
            bool rv = phrase_parse(iter, end, +fn, ws, ast);

            if (rv && (iter == end))
            {
                comp::code_gen::compiler cl(eh);

                if (cl(ast))
                {
                    cl.print_assembler();
                }
            }
        }
        catch (std::exception const& ex)
        {
            std::cerr << input_filename.c_str() << "(" << eh.linenum << "): " << ex.what() << std::endl;
        }
    }
    catch (std::exception const& ex)
    {
        std::cerr << ex.what() << std::endl;
    }

	return 0;
}

