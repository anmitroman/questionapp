15.times do
  title = Faker::Hipster.sentence(word_count: 2)
  body = Faker::Lorem.paragraph(sentence_count: 7, supplemental: true, random_sentences_to_add: 4)
  Quest.create title: title, body: body
end
