FROM mcr.microsoft.com/playwright:v1.52.0-jammy

# ── Node.js (latest LTS via NodeSource) ──────────────────────────────────────
RUN apt-get update && apt-get install -y curl wget unzip gnupg2 ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && node -v && npm -v

# ── GitHub CLI ────────────────────────────────────────────────────────────────
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
        https://cli.github.com/packages stable main" \
        | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update && apt-get install -y gh \
    && gh --version

# ── GitHub Copilot CLI  ───────────────────────────────────────────────────────
RUN npm install -g @githubnext/github-copilot-cli \
    && github-copilot-cli --version || true

# ── Cleanup ───────────────────────────────────────────────────────────────────
RUN apt-get clean && rm -rf /var/lib/apt/lists/*