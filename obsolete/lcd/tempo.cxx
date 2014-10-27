#if 0
// -------------------------------------------------------

enum LCDFlags
{
	_1602 = 1,
	_1604,
};

namespace wcd
{
	struct i2c_lcd
	{
		i2c_lcd(uint8_t sda, uint8_t scl, uint16_t flags)
			: sda_(sda)
			, scl_(scl)
			, flags_(flags)
		{}

		void start()
		{

		}

	private:
		uint8_t sda_;
		uint8_t scl_;
		uint16_t flags_;
	};
}

// -------------------------------------------------------

#endif // 0
