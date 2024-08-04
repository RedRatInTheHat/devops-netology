import sentry_sdk
from sentry_sdk import capture_message
from sentry_sdk import configure_scope
from sentry_sdk import set_tag

sentry_sdk.init(
    dsn="https://d816728760168605029ec9df5d754f5d@o4507719117176832.ingest.de.sentry.io/4507719142146128",
    traces_sample_rate=1.0,
    profiles_sample_rate=1.0,
    debug=True,
    environment="Test",
    attach_stacktrace=True,
)

sentry_sdk.set_context("character", {
    "name": "Alice",
    "age": 7,
    "place": "wonderland"
})

set_tag("category", "social_eating")

with configure_scope() as scope:
    scope.add_attachment(path="../images/her_name_is_alice.png")


class Alice:
    def eat_the_cake(self):
        capture_message("Goodbye, my poor legs.")

    def drink_the_bottle(self):
        capture_message("Now i can open the door!")

    def chase_the_rabbit(self):
        return self.check_the_hole()
    
    def check_the_hole(self):
        raise Exception('im falling! and i can\'t get up!')

Alice().eat_the_cake()
Alice().drink_the_bottle()
Alice().chase_the_rabbit()