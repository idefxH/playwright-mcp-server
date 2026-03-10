FROM python:3.12-slim

# Install Node.js (required for @playwright/mcp)
RUN apt-get update && apt-get install -y --no-install-recommends curl && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install mcp-proxy (Python) and @playwright/mcp@0.0.56
# Pinned to 0.0.56 = last version using Playwright 1.58 (matches browserless chromium:latest)
# When upgrading browserless to Playwright 1.59+, bump to @playwright/mcp@0.0.57+
RUN pip install --no-cache-dir mcp-proxy && \
    npm install -g @playwright/mcp@0.0.56

EXPOSE 3000

ENV CDP_ENDPOINT=ws://browserless:3000/playwright/chromium

CMD ["sh", "-c", "mcp-proxy --pass-environment --host 0.0.0.0 --port 3000 -- npx @playwright/mcp@0.0.56 --cdp-endpoint $CDP_ENDPOINT"]
