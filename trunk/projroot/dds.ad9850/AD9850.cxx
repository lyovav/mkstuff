#include "AD9850.hxx"

namespace dds
{
	// change if ad9850 is connected to other frequency crystal oscillator
	static const double EX_CLK = 125.0e6;

	#define pulse(pin) do { digitalWrite(pin, HIGH); digitalWrite(pin, LOW); } while (0)

	AD9850::AD9850(uint8_t w_clk, uint8_t fq_ud, uint8_t d7, uint8_t rst)
		: W_CLK(w_clk)
		, FQ_UD(fq_ud)
		, D7(d7)
	{
		frequency = 0;
		phase = 0;
		pinMode(W_CLK, OUTPUT);
		pinMode(FQ_UD, OUTPUT);
		pinMode(D7, OUTPUT);
		pinMode(rst, OUTPUT);

		pulse(rst);
		pulse(W_CLK);
		pulse(FQ_UD);
	}

	void AD9850::update()
	{
		uint32_t f = frequency;
		for (int i = 0; i < 32; i++, f >>= 1)
		{
			digitalWrite(D7, f & (uint32_t) 0x00000001);
			pulse(W_CLK);
		}

		uint8_t p = phase;
		for (int i = 0; i < 8; i++, p >>= 1)
		{
			digitalWrite(D7, p & (uint8_t) 0x01);
			pulse(W_CLK);
		}

		pulse(FQ_UD);
	}

	void AD9850::setfreq(double f)
	{
		frequency = f * 4294967296.0 / EX_CLK;
		update();
	}

	void AD9850::setphase(uint8_t p)
	{
		phase = p << 3;
		update();
	}

	void AD9850::down()
	{
		pulse(FQ_UD);
		uint8_t p = 0x04;
		for (int i = 0; i < 8; i++, p >>= 1)
		{
			digitalWrite(D7, p & (uint8_t) 0x01);
			pulse(W_CLK);
		}
		pulse(FQ_UD);
	}
}

