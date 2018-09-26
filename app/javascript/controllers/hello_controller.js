import cable from "actioncable";
import { Controller } from "stimulus"

const consumer = cable.createConsumer()

const callback = (outputTarget) => { return {
    received({ message, scores }) {
      // todo update scores
      // refresh rounds
      console.log( scores )
    }
  }
}

export default class extends Controller {
  connect() {
    const game_id = this.data.get('game-id');
    const channel = { channel: "ScoreChannel", game_id: game_id }
    const chat = consumer.subscriptions.create( channel, callback(this.outputTarget) );
  }
}
