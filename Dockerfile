FROM ruby:3.2.0

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g yarn

COPY entrypoint.sh ./entrypoint.sh
COPY entrypoint-script/wait-for-it.sh /entrypoint-script/wait-for-it.sh
COPY entrypoint-script/after-db-config.sh /entrypoint-script/after-db-config.sh

RUN chown root:root /entrypoint.sh /entrypoint-script/wait-for-it.sh /entrypoint-script/after-db-config.sh && \
    chmod +x /entrypoint.sh /entrypoint-script/wait-for-it.sh /entrypoint-script/after-db-config.sh

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY package.json /app/
COPY yarn.lock /app/
RUN yarn install

COPY . /app

RUN NODE_ENV=production yarn vite build

ENTRYPOINT ["/entrypoint.sh"]
