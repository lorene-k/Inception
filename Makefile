FILEPATH	=	./srcs/docker-compose.yml
COMPOSE		=	docker compose -f

# ------------  RULES  ------------------------------------------------------ #
all:			up

up:
				@$(COMPOSE) $(FILEPATH) up -d

down:
				@$(COMPOSE) $(FILEPATH) down

start:
				@$(COMPOSE) $(FILEPATH) start

stop:
				@$(COMPOSE) $(FILEPATH) stop

rmi:
				docker image prune -a

fclean:			down rmi

re:				fclean all

.PHONY:			all up down start stop rmi fclean re