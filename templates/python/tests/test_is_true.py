"""test is_true module"""

import unittest

from project import is_true


class TestIsTrue(unittest.TestCase):
    """Controller for the is true tests"""

    def test_is_true(self):
        """Test is_true"""

        self.assertTrue(is_true())

if __name__ == "__main__":
    unittest.main()