#include "AD9850.hxx"

namespace dds
{
    // change if ad9850 is connected to other frequency crystal oscillator
    static const double EX_CLK = 125.0e6;

    #define pulse(pin) do { digitalWrite(pin, HIGH); digitalWrite(pin, LOW); } while (0)

    AD9850::AD9850(uint8_t w_clk, uint8_t fq_ud, uint8_t d7, uint8_t rst)
		: W_CLK_(w_clk)
		, FQ_UD_(fq_ud)
		, D7_(d7)
    {
        frequency_ = 0;
        phase_ = 0;
        pinMode(W_CLK_, OUTPUT);
        pinMode(FQ_UD_, OUTPUT);
        pinMode(D7_, OUTPUT);
        pinMode(rst, OUTPUT);

        //pulse(rst);
        pulse(W_CLK_);
        pulse(FQ_UD_);
    }

    void AD9850::update() const
    {
        uint32_t f = frequency_;
        for (int i = 0; i < 32; i++, f >>= 1)
        {
            digitalWrite(D7_, f & (uint32_t) 0x00000001);
            pulse(W_CLK_);
        }

        uint8_t p = phase_;
        for (int i = 0; i < 8; i++, p >>= 1)
        {
            digitalWrite(D7_, p & (uint8_t) 0x01);
            pulse(W_CLK_);
        }

        pulse(FQ_UD_);
    }

    void AD9850::setfreq(double f)
    {
        frequency_ = f * 4294967296.0 / EX_CLK;
        update();
    }

    void AD9850::setphase(uint8_t p)
    {
        phase_ = p << 3;
        update();
    }

    void AD9850::down() const
    {
        pulse(FQ_UD_);
        uint8_t p = 0x04;
        for (int i = 0; i < 8; i++, p >>= 1)
        {
            digitalWrite(D7_, p & (uint8_t) 0x01);
            pulse(W_CLK_);
        }
        pulse(FQ_UD_);
    }
}

