import sys
from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.util import ClassNotFound
from pygments.formatters import HtmlFormatter

formatter = HtmlFormatter(linenos=False, cssclass="h", encoding="utf-8")

try:
    lexer = get_lexer_by_name(sys.stdin.readline().strip(), encoding="guess")
except ClassNotFound:
    lexer = get_lexer_by_name("text", encoding="guess")

sys.stdout.write(highlight(sys.stdin.read(), lexer, formatter).decode("utf-8"))
sys.stdout.flush()
exit(0)
