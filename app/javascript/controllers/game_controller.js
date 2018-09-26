import cable from "actioncable";
import { Controller } from "stimulus"

const consumer = cable.createConsumer()

const callback = (score1, score2, score3, score4, rounds) => { return {
    received({ message, scores, rounds_html }) {
      switch (message) {
        case 'scores':
          console.log('updating scores', scores)
          score1.textContent = scores[0];
          score2.textContent = scores[1];
          score3.textContent = scores[2];
          score4.textContent = scores[3];
          rounds.innerHTML = rounds_html;
          break;
        default:
          console.log('message unknown:', message)
      }
    }
  }
}

export default class extends Controller {
  static targets = [ "score1", "score2", "score3", "score4", "rounds", "roundForm" ]
  connect() {
    console.log('initializing game controller')
    window.t = this.roundFormTarget
    this.roundFormTarget.addEventListener('ajax:success', (e, data, status, xhr) => {
      this.roundFormTarget.reset();
    })
    const game_id = this.data.get('id')
    const channel = { channel: "ScoreChannel", game_id: game_id }
    const chat = consumer.subscriptions.create( channel, callback(this.score1Target, this.score2Target, this.score3Target, this.score4Target, this.roundsTarget) );
  }
}
