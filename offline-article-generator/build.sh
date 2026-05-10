#!/bin/bash
# Build single HTML file with inlined libraries
cd "$(dirname "$0")"

cat > research-article-generator.html << 'HTMLSTART'
__PLACEHOLDER__
HTMLSTART

# Inline libraries by replacing placeholders
python3 << 'PYEOF'
with open('jspdf.min.js') as f: jspdf = f.read()
with open('html2canvas.min.js') as f: h2c = f.read()
with open('jszip.min.js') as f: jszip = f.read()

with open('app.html') as f: html = f.read()
html = html.replace('/*__JSPDF__*/', jspdf)
html = html.replace('/*__HTML2CANVAS__*/', h2c)
html = html.replace('/*__JSZIP__*/', jszip)

with open('research-article-generator.html','w') as f: f.write(html)
print(f"Built: {len(html)//1024} KB")
PYEOF
