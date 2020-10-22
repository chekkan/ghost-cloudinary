FROM ghost:3.35.5-alpine

WORKDIR $GHOST_INSTALL

RUN npm install ghost-cloudinary-store --no-package-lock \
    && cp -r node_modules/ghost-cloudinary-store versions/$GHOST_VERSION/core/server/adapters/storage \
    && mkdir -p $GHOST_CONTENT/adapters/storage \
    && ls -al $GHOST_CONTENT \
    && cp -r node_modules/ghost-cloudinary-store $GHOST_CONTENT/adapters/storage/

COPY config.production.json .

VOLUME $GHOST_CONTENT

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 2368
CMD ["node", "current/index.js"]