package dao;

import bean.IModel;

public abstract class AbsDAO<T extends IModel> implements IDAO<T> {
    @Override
    public int insert(T model) {
    LogDAO.insert(model);
    return 0;
}
    @Override
    public int update(T model) {
        LogDAO.update(model);
        return 0;
    }

    @Override
    public int delete(T model) {
        return 0;
    }
}
