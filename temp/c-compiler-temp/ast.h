#pragma once

#include "common.h"
#include <string>

namespace comp { namespace ast 
{
    struct tagged
    {
        int id;
    };

    struct nil {};
    struct unary;
    struct function_call;
    struct expression;

    struct identifier : tagged
    {
        identifier(std::string const& name = "") 
            : name(name) 
        {}

        std::string name;
    };

    typedef boost::variant<
        nil
        , bool
        , unsigned int
        , identifier
        , boost::recursive_wrapper<unary>
        , boost::recursive_wrapper<function_call>
        , boost::recursive_wrapper<expression>
    >
    operand;

    enum optoken
    {
        op_plus,
        op_minus,
        op_times,
        op_divide,
        op_positive,
        op_negative,
        op_not,
        op_equal,
        op_not_equal,
        op_less,
        op_less_equal,
        op_greater,
        op_greater_equal,
        op_and,
        op_or
    };

    struct unary
    {
        optoken operator_;
        operand operand_;
    };

    struct operation
    {
        optoken operator_;
        operand operand_;
    };

    struct function_call
    {
        identifier function_name;
        std::list<expression> args;
    };

    struct expression
    {
        operand first;
        std::list<operation> rest;
    };

    struct assignment
    {
        identifier lhs;
        expression rhs;
    };

    struct variable_declaration
    {
        identifier lhs;
        boost::optional<expression> rhs;
    };

    struct if_statement;
    struct while_statement;
    struct statement_list;
    struct return_statement;

    typedef boost::variant<
        variable_declaration
        , assignment
        , boost::recursive_wrapper<if_statement>
        , boost::recursive_wrapper<while_statement>
        , boost::recursive_wrapper<return_statement>
        , boost::recursive_wrapper<statement_list>
    >
    statement;

    struct statement_list : std::list<statement> {};

    struct if_statement
    {
        expression condition;
        statement then;
        boost::optional<statement> else_;
    };

    struct while_statement
    {
        expression condition;
        statement body;
    };

    struct return_statement : tagged
    {
        boost::optional<expression> expr;
    };

    struct function
    {
        std::string return_type;
        identifier function_name;
        std::list<identifier> args;
        statement_list body;
    };

    typedef std::list<function> function_list;

    // print functions for debugging
    inline std::ostream& operator<<(std::ostream& out, nil)
    {
        out << "nil"; return out;
    }

    inline std::ostream& operator<<(std::ostream& out, identifier const& id)
    {
        out << id.name; return out;
    }
}}

BOOST_FUSION_ADAPT_STRUCT(
    comp::ast::unary,
    (comp::ast::optoken, operator_)
    (comp::ast::operand, operand_)
)

BOOST_FUSION_ADAPT_STRUCT(
    comp::ast::operation,
    (comp::ast::optoken, operator_)
    (comp::ast::operand, operand_)
)

BOOST_FUSION_ADAPT_STRUCT(
    comp::ast::function_call,
    (comp::ast::identifier, function_name)
    (std::list<comp::ast::expression>, args)
)

BOOST_FUSION_ADAPT_STRUCT(
    comp::ast::expression,
    (comp::ast::operand, first)
    (std::list<comp::ast::operation>, rest)
)

BOOST_FUSION_ADAPT_STRUCT(
    comp::ast::variable_declaration,
    (comp::ast::identifier, lhs)
    (boost::optional<comp::ast::expression>, rhs)
)

BOOST_FUSION_ADAPT_STRUCT(
    comp::ast::assignment,
    (comp::ast::identifier, lhs)
    (comp::ast::expression, rhs)
)

BOOST_FUSION_ADAPT_STRUCT(
    comp::ast::if_statement,
    (comp::ast::expression, condition)
    (comp::ast::statement, then)
    (boost::optional<comp::ast::statement>, else_)
)

BOOST_FUSION_ADAPT_STRUCT(
    comp::ast::while_statement,
    (comp::ast::expression, condition)
    (comp::ast::statement, body)
)

BOOST_FUSION_ADAPT_STRUCT(
    comp::ast::return_statement,
    (boost::optional<comp::ast::expression>, expr)
)

BOOST_FUSION_ADAPT_STRUCT(
    comp::ast::function,
    (std::string, return_type)
    (comp::ast::identifier, function_name)
    (std::list<comp::ast::identifier>, args)
    (comp::ast::statement_list, body)
)
