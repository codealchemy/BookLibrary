FactoryBot.define do
  factory :book do
    title { 'The Alchemist' }
    isbn  { '978-0061122415' }
    description do
      "The Alchemist is the magical story of Santiago, an "\
      "Andalusian shepherd boy who yearns to travel in search "\
      "of a worldly treasure as extravagant as any ever found. "\
      "From his home in Spain he journeys to the markets of "\
      "Tangiers and across the Egyptian desert to a fateful "\
      "encounter with the alchemist."
    end
  end
end
