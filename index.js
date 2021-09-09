const fetch = require("node-fetch");

fetch(
  "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow"
)
  .then((response) => response.json())
  .then((json) => {
    const getAnswerInfo = () => {
      let answered = (notAnswered = counter = 0);

      do {
        if (json["items"][counter]["is_answered"] === true) {
          answered = answered + 1;
        } else {
          notAnswered = notAnswered + 1;
        }
        counter = counter + 1;
      } while (Object.keys(json["items"]).length > counter);

      console.log(
        `\n Obtener el número de respuestas contestadas y no contestadas 
        Total de preguntas contestadas: ${answered} 
        Total de preguntas no contestadas: ${notAnswered} \n`
      );
    };

    const getOwner = () => {
      const result = Math.max.apply(
        Math,
        json.items.map((objectAnswer) => {
          return (
            objectAnswer.owner.hasOwnProperty("reputation") &&
            objectAnswer.owner.reputation
          );
        })
      );

      console.log(
        `Obtener la respuesta con mayor owners 
        La respuesta con mas owners tiene: ${result} \n`
      );
    };

    const getFewerViews = () => {
      const result = Math.min.apply(
        Math,
        json.items.map((objectAnswer) => {
          return objectAnswer.view_count;
        })
      );
      console.log(
        `Obtener la respuesta con menor número de vistas 
        la respuesta con menor número de vistas: tiene ${result} vistas \n`
      );
    };

    const getMinMaxAnswer = () => {
      const newestQuestion = Math.max.apply(
        Math,
        json.items.map((objectAnswer) => {
          return objectAnswer.creation_date;
        })
      );

      const oldestQuestion = Math.min.apply(
        Math,
        json.items.map(function (objectAnswer) {
          return objectAnswer.creation_date;
        })
      );

      console.log(
        `Obtener la respuesta mas vieja y mas actual 
        La respuesta mas nueva es: ${newestQuestion}
        La respuesta mas vieja es: ${oldestQuestion} \n`
      );
    };

    getAnswerInfo();
    getOwner();
    getFewerViews();
    getMinMaxAnswer();
  });
