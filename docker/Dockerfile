FROM mcr.microsoft.com/playwright:v1.59.1-jammy

# ── Node.js (latest LTS) ──────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y curl wget unzip gnupg2 ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && node -v && npm -v

# ── Pre-install all project dependencies globally ─────────────────────────────
RUN npm install -g \
    @cucumber/cucumber@10.0.0 \
    @playwright/test@1.59.1 \
    @types/node@20.9.4 \
    allure-commandline@2.29.0 \
    allure-playwright@2.15.1 \
    cross-env@7.0.3 \
    nodemon@3.0.1 \
    npm-run-all@1.1.3 \
    pirates@4.0.7 \
    playwright-bdd@8.5.0 \
    typescript@5.3.2 \
    @axe-core/playwright@4.10.2 \
    axios@1.7.7 \
    dotenv@16.4.5

# ── Set NODE_PATH so projects find global packages ────────────────────────────
ENV NODE_PATH=/usr/lib/node_modules

# ── GitLab CLI ────────────────────────────────────────────────────────────────
RUN GLAB_VERSION=$(curl -s "https://gitlab.com/api/v4/projects/gitlab-org%2Fcli/releases" \
        | grep -o '"tag_name":"[^"]*' | head -1 | cut -d'"' -f4 | tr -d 'v') \
    && curl -fsSL "https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_linux_amd64.deb" \
        -o glab.deb \
    && dpkg -i glab.deb \
    && rm glab.deb \
    && glab --version

# ── GitHub Copilot CLI (Official) ─────────────────────────────────────────────
RUN curl -fsSL https://gh.io/copilot-install | bash \
    && copilot --version || true

# ── Cleanup ───────────────────────────────────────────────────────────────────
RUN apt-get clean && rm -rf /var/lib/apt/lists/*