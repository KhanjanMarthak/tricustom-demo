import { userTable } from "../database/db.js";

export const signUp = (req, res) => {
  res.render("index");
};

export const signUpUser = async (req, res) => {
  try {
    const { email, password, username } = req.body;
    const newUser = await userTable.create({
      email,
      password,
      username,
    });
    res.send(newUser);
  } catch (error) {
    throw new Error(error);
  }
};
