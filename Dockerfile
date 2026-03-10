FROM node:22-slim

RUN npm install -g supergateway @playwright/mcp@latest

EXPOSE 3000

ENV CDP_ENDPOINT=ws://browserless:3000/playwright/chromium

CMD sh -c 'supergateway --stdio "npx -y @playwright/mcp@latest --cdp-endpoint $CDP_ENDPOINT" --port 3000 --host 0.0.0.0'
