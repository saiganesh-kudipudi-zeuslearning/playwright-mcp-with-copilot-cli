FROM mcr.microsoft.com/playwright:v1.59.1-jammy

# ── Node.js (latest LTS) ──────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y curl wget unzip gnupg2 ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && node -v && npm -v

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