/**
 * Sample security questions in Amharic and English
 * These are provided as examples but users can define their own questions
 */

const sampleSecurityQuestions = [
  // Amharic questions
  'ምሕላ: የልጅነት ቋሊ ሰፈርዎ ማን ነበር?', // What was your childhood neighborhood?
  'ምሕላ: የመጀመሪያ ትምህርት ቤት ማን ነበር?', // What was your first school?
  'ምሕላ: የመጀመሪያ ድራማ ማን ነበር?', // What was your first drama?
  'ምሕላ: የመጀመሪያ መምህር ማን ነበር?', // Who was your first teacher?
  'ምሕላ: የመጀመሪያ ፊልም ማን ነበር?', // What was your first film?
  
  // English questions (for reference and backup)
  'Security Question: What was your childhood neighborhood?',
  'Security Question: What was your first school?',
  'Security Question: What was your first drama?',
  'Security Question: Who was your first teacher?',
  'Security Question: What was your first film?'
];

/**
 * Validates basic structure of security questions
 * @param {object} securityQuestions - The questions object to validate
 * @returns {boolean} - True if valid structure, false otherwise
 */
const validateSecurityQuestions = (securityQuestions) => {
  return (
    securityQuestions &&
    securityQuestions.question1 &&
    securityQuestions.question1.question &&
    securityQuestions.question1.answer &&
    securityQuestions.question2 &&
    securityQuestions.question2.question &&
    securityQuestions.question2.answer
  );
};

module.exports = {
  sampleSecurityQuestions,
  validateSecurityQuestions
}; 