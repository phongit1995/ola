.class public Lchat/ola/vn/h/b;
.super Ljava/lang/Object;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale",
        "NewApi"
    }
.end annotation


# static fields
.field private static a:Z = false


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private static A(Ljava/lang/String;)Lchat/ola/vn/w/s;
    .locals 5

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    const-string v0, ".info.dat"

    monitor-enter v0

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_2

    new-instance v3, Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    const-string v4, ".info.dat"

    invoke-direct {v3, v2, v4}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_2

    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-static {v2}, Lchat/ola/vn/util/o;->a(Ljava/io/InputStream;)Lchat/ola/vn/w/s;

    move-result-object v3

    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez v3, :cond_1

    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    return-object v1

    :cond_1
    :try_start_3
    invoke-static {p0, v3}, Lchat/ola/vn/h/b;->d(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-eqz p0, :cond_2

    :try_start_4
    monitor-exit v0

    return-object v3

    :catch_0
    :cond_2
    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw p0
.end method

.method public static a()J
    .locals 4

    const-wide/16 v0, 0x0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h/b;->h()Lchat/ola/vn/w/s;

    move-result-object v2

    if-nez v2, :cond_0

    return-wide v0

    :cond_0
    invoke-static {v2}, Lchat/ola/vn/h/b;->a(Lchat/ola/vn/w/s;)Z

    move-result v3

    if-eqz v3, :cond_2

    const/16 v3, 0x47

    invoke-virtual {v2, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    return-wide v0

    :cond_1
    invoke-static {v2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v2

    :catch_0
    :cond_2
    return-wide v0
.end method

.method public static a(Landroid/content/Context;)Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/h/a;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v1

    const v2, 0x7f0f001e

    invoke-virtual {p0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Landroid/accounts/AccountManager;->getAccountsByType(Ljava/lang/String;)[Landroid/accounts/Account;

    move-result-object p0

    if-eqz p0, :cond_2

    array-length v2, p0

    if-lez v2, :cond_2

    array-length v2, p0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_1

    aget-object v4, p0, v3

    new-instance v5, Lchat/ola/vn/h/a;

    invoke-direct {v5}, Lchat/ola/vn/h/a;-><init>()V

    iput-object v4, v5, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    :try_start_1
    invoke-virtual {v1, v4}, Landroid/accounts/AccountManager;->getPassword(Landroid/accounts/Account;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v5, Lchat/ola/vn/h/a;->b:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    const-string v6, "_time"

    invoke-virtual {v1, v4, v6}, Landroid/accounts/AccountManager;->getUserData(Landroid/accounts/Account;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v6

    iput-wide v6, v5, Lchat/ola/vn/h/a;->e:J
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :try_start_3
    const-string v6, "_trust_token"

    invoke-virtual {v1, v4, v6}, Landroid/accounts/AccountManager;->getUserData(Landroid/accounts/Account;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v5, Lchat/ola/vn/h/a;->d:Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    if-nez v0, :cond_0

    :try_start_4
    new-instance v4, Ljava/util/ArrayList;

    array-length v6, p0

    invoke-direct {v4, v6}, Ljava/util/ArrayList;-><init>(I)V

    move-object v0, v4

    :cond_0
    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    if-eqz v0, :cond_2

    new-instance p0, Lchat/ola/vn/e/a;

    invoke-direct {p0}, Lchat/ola/vn/e/a;-><init>()V

    invoke-static {v0, p0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :catch_3
    :cond_2
    :try_start_5
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    invoke-virtual {p0}, Lchat/ola/vn/e;->n()Ljava/util/List;

    move-result-object p0

    if-eqz p0, :cond_a

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_a

    if-eqz v0, :cond_9

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-nez v1, :cond_3

    goto :goto_3

    :cond_3
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_4
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_7

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/h/a;

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_5
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/h/a;

    iget-object v5, v2, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v5, v5, Landroid/accounts/Account;->name:Ljava/lang/String;

    iget-object v6, v4, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v6, v6, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v5, v6}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_5

    iget-object v5, v2, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    invoke-static {v5}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_6

    iget-object v5, v4, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    invoke-static {v5}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_6

    iget-object v5, v4, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    iput-object v5, v2, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    iget-object v5, v4, Lchat/ola/vn/h/a;->c:Ljava/lang/String;

    iput-object v5, v2, Lchat/ola/vn/h/a;->c:Ljava/lang/String;

    iget-object v5, v4, Lchat/ola/vn/h/a;->d:Ljava/lang/String;

    iput-object v5, v2, Lchat/ola/vn/h/a;->d:Ljava/lang/String;

    iget-wide v4, v4, Lchat/ola/vn/h/a;->e:J

    iput-wide v4, v2, Lchat/ola/vn/h/a;->e:J

    :cond_6
    invoke-interface {v3}, Ljava/util/Iterator;->remove()V

    goto :goto_1

    :cond_7
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_2
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_8

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/h/a;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_8
    new-instance p0, Lchat/ola/vn/e/a;

    invoke-direct {p0}, Lchat/ola/vn/e/a;-><init>()V

    invoke-static {v0, p0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_4

    goto :goto_4

    :cond_9
    :goto_3
    :try_start_6
    new-instance v0, Lchat/ola/vn/e/a;

    invoke-direct {v0}, Lchat/ola/vn/e/a;-><init>()V

    invoke-static {p0, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    return-object p0

    :catch_4
    :cond_a
    :goto_4
    move-object p0, v0

    :catch_5
    return-object p0
.end method

.method public static a([B)Ljava/util/List;
    .locals 14
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/g;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-static {v1}, Lchat/ola/vn/util/o;->a(Ljava/io/InputStream;)Lchat/ola/vn/w/s;

    move-result-object p0

    const/16 v1, 0x1e

    invoke-virtual {p0, v1}, Lchat/ola/vn/w/s;->c(S)I

    move-result v8

    if-lez v8, :cond_3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v8}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v9, 0x0

    invoke-virtual {p0, v1, v9}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    move v11, v2

    const/4 v10, 0x0

    :goto_0
    if-ge v10, v8, :cond_3

    invoke-virtual {p0, v1, v11}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v12

    invoke-virtual {p0, v11}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v2

    const-string v3, "my diary"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    const-string v3, "mariage diary"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    goto :goto_1

    :cond_1
    const/16 v3, 0x1f

    invoke-virtual {p0, v3, v11, v12}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v3

    new-instance v13, Lchat/ola/vn/entry/g;

    invoke-direct {v13, v2, v3}, Lchat/ola/vn/entry/g;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const/16 v2, 0x2c

    invoke-virtual {p0, v2, v11, v12}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v13, v2}, Lchat/ola/vn/entry/g;->b(Ljava/lang/String;)V

    const/16 v3, 0x2a

    const-wide/16 v6, 0x0

    move-object v2, p0

    move v4, v11

    move v5, v12

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v2

    invoke-virtual {v13, v2, v3}, Lchat/ola/vn/entry/g;->a(J)V

    const/16 v2, 0x2b

    invoke-virtual {p0, v2, v11, v12, v9}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v2

    int-to-long v2, v2

    invoke-virtual {v13, v2, v3}, Lchat/ola/vn/entry/g;->b(J)V

    const/16 v3, 0x22

    move-object v2, p0

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v2

    invoke-virtual {v13, v2, v3}, Lchat/ola/vn/entry/g;->c(J)V

    invoke-interface {v0, v13}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    :goto_1
    add-int/lit8 v10, v10, 0x1

    move v11, v12

    goto :goto_0

    :cond_3
    return-object v0
.end method

.method public static a(I)V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$15;

    invoke-direct {v0, p0}, Lchat/ola/vn/h/b$15;-><init>(I)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 v1, 0x0

    if-eqz p0, :cond_0

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v1, v1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, v1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_0
    new-array p0, v1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(J)V
    .locals 1

    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$7;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$7;-><init>(J)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_0

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_0
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 5

    :try_start_0
    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v0

    const v1, 0x7f0f001e

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/accounts/AccountManager;->getAccountsByType(Ljava/lang/String;)[Landroid/accounts/Account;

    move-result-object p0

    if-eqz p0, :cond_1

    array-length v1, p0

    if-lez v1, :cond_1

    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, p0, v2

    iget-object v4, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v4, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    const/4 p0, 0x0

    invoke-virtual {v0, v3, p0, p0}, Landroid/accounts/AccountManager;->removeAccount(Landroid/accounts/Account;Landroid/accounts/AccountManagerCallback;Landroid/os/Handler;)Landroid/accounts/AccountManagerFuture;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    :goto_1
    :try_start_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    invoke-virtual {p0, p1}, Lchat/ola/vn/e;->f(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p0

    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object p0

    const v0, 0x7f0f001e

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/accounts/AccountManager;->getAccountsByType(Ljava/lang/String;)[Landroid/accounts/Account;

    move-result-object v0

    if-eqz v0, :cond_1

    array-length v1, v0

    if-lez v1, :cond_1

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    iget-object v4, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-virtual {p0, v3, p2}, Landroid/accounts/AccountManager;->setPassword(Landroid/accounts/Account;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    :goto_1
    :try_start_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/e;->a(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    :try_start_0
    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v0

    new-instance v1, Landroid/accounts/Account;

    const v2, 0x7f0f001e

    invoke-virtual {p0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, p1, v2}, Landroid/accounts/Account;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v2, 0x0

    invoke-virtual {v0, v1, p2, v2}, Landroid/accounts/AccountManager;->addAccountExplicitly(Landroid/accounts/Account;Ljava/lang/String;Landroid/os/Bundle;)Z

    move-result v2

    if-eqz v2, :cond_0

    const v2, 0x7f0f06e9

    invoke-virtual {p0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, v1, p0, p3}, Landroid/accounts/AccountManager;->setAuthToken(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    invoke-virtual {v0, v1, p2}, Landroid/accounts/AccountManager;->setPassword(Landroid/accounts/Account;Ljava/lang/String;)V

    :goto_0
    const-string p0, "_time"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p0, v2}, Landroid/accounts/AccountManager;->setUserData(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {p4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_1

    const-string p0, "_trust_token"

    invoke-virtual {v0, v1, p0, p4}, Landroid/accounts/AccountManager;->setUserData(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    :try_start_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    invoke-virtual {p0, p1, p2, p3, p4}, Lchat/ola/vn/e;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method private static a(Lchat/ola/vn/w/cg;)V
    .locals 4

    const-string v0, ".app2.info"

    monitor-enter v0

    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->f()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    const-string v3, ".app.info"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    :cond_0
    new-instance v1, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->f()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    const-string v3, ".app2.info"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z

    :cond_1
    invoke-static {v1, p0}, Lchat/ola/vn/h/b;->a(Ljava/io/File;Lchat/ola/vn/w/cg;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    :try_start_2
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p0
.end method

.method private static a(Ljava/io/File;Lchat/ola/vn/w/cg;)V
    .locals 3

    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    new-instance p0, Lchat/ola/vn/w/cg;

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lchat/ola/vn/w/cg;-><init>(S)V

    const-string v1, "3.0"

    const/4 v2, 0x1

    invoke-virtual {p0, v2, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {p1}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V

    return-void
.end method

.method private static a(Ljava/io/File;Ljava/util/List;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    new-instance p0, Lchat/ola/vn/w/cg;

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lchat/ola/vn/w/cg;-><init>(S)V

    const-string v2, "3.0"

    const/4 v3, 0x1

    invoke-virtual {p0, v3, v2}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    if-eqz p1, :cond_3

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    :goto_0
    if-ge v1, v2, :cond_3

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/message/f;

    const/16 v4, 0x19

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v4, v5}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_0

    const/16 v5, 0x1a

    invoke-virtual {p0, v5, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    invoke-virtual {v3}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_1

    const/16 v5, 0x26

    invoke-virtual {p0, v5, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    invoke-virtual {v3}, Lchat/ola/vn/message/f;->o()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_2

    const/16 v4, 0x9

    invoke-virtual {p0, v4, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V

    return-void
.end method

.method static synthetic a(Ljava/io/File;Ljava/util/List;I)V
    .locals 0

    invoke-static {p0, p1, p2}, Lchat/ola/vn/h/b;->b(Ljava/io/File;Ljava/util/List;I)V

    return-void
.end method

.method public static a(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$17;

    invoke-direct {v0, p0}, Lchat/ola/vn/h/b$17;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 v1, 0x0

    if-eqz p0, :cond_0

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v1, v1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, v1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_0
    new-array p0, v1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Ljava/lang/String;B)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$2;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$2;-><init>(Ljava/lang/String;B)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Ljava/lang/String;Lchat/ola/vn/me/a;)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$12;

    invoke-direct {v0, p1, p0}, Lchat/ola/vn/h/b$12;-><init>(Lchat/ola/vn/me/a;Ljava/lang/String;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static a(Ljava/lang/String;Lchat/ola/vn/w/cg;)V
    .locals 3

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const-string v0, ".info.dat"

    monitor-enter v0

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_2

    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v2, ".info.dat"

    invoke-direct {v1, p0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result p0

    if-nez p0, :cond_1

    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z

    :cond_1
    invoke-static {v1, p1}, Lchat/ola/vn/h/b;->b(Ljava/io/File;Lchat/ola/vn/w/cg;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    :cond_2
    :try_start_2
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p0
.end method

.method public static a(Ljava/lang/String;Ljava/lang/Long;)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$19;

    invoke-direct {v0, p1, p0}, Lchat/ola/vn/h/b$19;-><init>(Ljava/lang/Long;Ljava/lang/String;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;I[B)V
    .locals 3

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x2

    if-gt v0, v1, :cond_2

    return-void

    :cond_2
    const/4 v0, 0x4

    if-ne p2, v0, :cond_3

    return-void

    :cond_3
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_7

    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v1, ".message"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p0

    if-nez p0, :cond_4

    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    :cond_4
    new-instance p0, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ".background."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "."

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p3, :cond_6

    :try_start_0
    array-length p1, p3

    if-lez p1, :cond_6

    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result p1

    if-nez p1, :cond_5

    invoke-virtual {p0}, Ljava/io/File;->createNewFile()Z

    :cond_5
    invoke-static {p0, p3}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;[B)V

    return-void

    :cond_6
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_7

    invoke-virtual {p0}, Ljava/io/File;->delete()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_7
    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    if-eqz p1, :cond_4

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_4

    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v1, ".me"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p0

    if-nez p0, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    :cond_2
    :try_start_0
    new-instance p0, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    const-string v1, ".lastviewme.dat"

    invoke-direct {p0, v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {p0}, Ljava/io/File;->createNewFile()Z

    :cond_3
    invoke-static {p0, p1}, Lchat/ola/vn/h/b;->b(Ljava/io/File;Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_4
    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/util/List;I)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;I)V"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$21;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/h/b$21;-><init>(Ljava/lang/String;Ljava/util/List;I)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Ljava/lang/String;SLjava/lang/String;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;SLjava/lang/String;)V

    return-void
.end method

.method public static a(Ljava/lang/String;Z)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$20;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$20;-><init>(Ljava/lang/String;Z)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Ljava/lang/String;[B)V
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v1, ".app.background"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p0

    if-nez p0, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z

    :cond_1
    invoke-static {v0, p1}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;[B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public static a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$16;

    invoke-direct {v0, p0}, Lchat/ola/vn/h/b$16;-><init>(Ljava/util/List;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 v1, 0x0

    if-eqz p0, :cond_0

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v1, v1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, v1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_0
    new-array p0, v1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(SLjava/lang/String;)V
    .locals 0

    invoke-static {p0, p1}, Lchat/ola/vn/h/b;->b(SLjava/lang/String;)V

    return-void
.end method

.method private static a(Lchat/ola/vn/w/s;)Z
    .locals 3

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    if-nez p0, :cond_1

    return v0

    :cond_1
    const-string v2, "3.0"

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_3

    invoke-static {}, Lchat/ola/vn/d;->f()Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_2

    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v2, ".app2.info"

    invoke-direct {v1, p0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_2

    invoke-static {v1}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    :cond_2
    return v0

    :cond_3
    return v1
.end method

.method private static a(Ljava/lang/String;Lchat/ola/vn/w/s;)Z
    .locals 3

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    const-string v2, "3.0"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_1

    new-instance p1, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v0, ".contact.dat"

    invoke-direct {p1, p0, v0}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_1

    invoke-static {p1}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    :cond_1
    return v1

    :cond_2
    return v0
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;I)[B
    .locals 4

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    :cond_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    return-object v0

    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x2

    if-gt v1, v2, :cond_2

    return-object v0

    :cond_2
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_5

    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v2, ".message"

    invoke-direct {v1, p0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result p0

    if-nez p0, :cond_3

    invoke-virtual {v1}, Ljava/io/File;->mkdir()Z

    :cond_3
    new-instance p0, Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ".background."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "."

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    :try_start_0
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result p1

    if-nez p1, :cond_4

    return-object v0

    :cond_4
    invoke-static {p0}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;)[B

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_5
    return-object v0
.end method

.method public static b()Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h/b;->h()Lchat/ola/vn/w/s;

    move-result-object v1

    if-nez v1, :cond_0

    return-object v0

    :cond_0
    invoke-static {v1}, Lchat/ola/vn/h/b;->a(Lchat/ola/vn/w/s;)Z

    move-result v2

    if-eqz v2, :cond_7

    const/16 v2, 0x4f

    invoke-virtual {v1, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_2

    new-instance v1, Ljava/util/ArrayList;

    sget-object v2, Lchat/ola/vn/f/d;->e_:[Ljava/lang/String;

    array-length v2, v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    :goto_0
    sget-object v2, Lchat/ola/vn/f/d;->e_:[Ljava/lang/String;

    array-length v2, v2

    if-ge v3, v2, :cond_1

    sget-object v2, Lchat/ola/vn/f/d;->e_:[Ljava/lang/String;

    aget-object v2, v2, v3

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    return-object v1

    :cond_2
    const-string v2, ";"

    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_5

    array-length v2, v1

    if-nez v2, :cond_3

    goto :goto_2

    :cond_3
    new-instance v2, Ljava/util/ArrayList;

    array-length v4, v1

    invoke-direct {v2, v4}, Ljava/util/ArrayList;-><init>(I)V

    :goto_1
    array-length v4, v1

    if-ge v3, v4, :cond_4

    aget-object v4, v1, v3

    invoke-interface {v2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_4
    return-object v2

    :cond_5
    :goto_2
    new-instance v1, Ljava/util/ArrayList;

    sget-object v2, Lchat/ola/vn/f/d;->e_:[Ljava/lang/String;

    array-length v2, v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    :goto_3
    sget-object v2, Lchat/ola/vn/f/d;->e_:[Ljava/lang/String;

    array-length v2, v2

    if-ge v3, v2, :cond_6

    sget-object v2, Lchat/ola/vn/f/d;->e_:[Ljava/lang/String;

    aget-object v2, v2, v3

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    :cond_6
    return-object v1

    :catch_0
    :cond_7
    return-object v0
.end method

.method public static b([B)Ljava/util/List;
    .locals 14
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/io/ByteArrayInputStream;

    invoke-direct {v0, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-static {v0}, Lchat/ola/vn/util/o;->a(Ljava/io/InputStream;)Lchat/ola/vn/w/s;

    move-result-object p0

    const/16 v0, 0x1e

    invoke-virtual {p0, v0}, Lchat/ola/vn/w/s;->c(S)I

    move-result v7

    if-lez v7, :cond_0

    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8, v7}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v9, 0x0

    invoke-virtual {p0, v0, v9}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    move v11, v1

    const/4 v10, 0x0

    :goto_0
    if-ge v10, v7, :cond_1

    invoke-virtual {p0, v0, v11}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v12

    new-instance v13, Lchat/ola/vn/entity/t;

    invoke-virtual {p0, v11}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v13, v1}, Lchat/ola/vn/entity/t;-><init>(Ljava/lang/String;)V

    const/16 v1, 0x1f

    invoke-virtual {p0, v1, v11, v12}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v13, v1}, Lchat/ola/vn/entity/t;->b(Ljava/lang/String;)V

    const/16 v1, 0x2b

    invoke-virtual {p0, v1, v11, v12, v9}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v1

    invoke-virtual {v13, v1}, Lchat/ola/vn/entity/t;->e(I)V

    const/16 v2, 0x2a

    const-wide/16 v5, 0x0

    move-object v1, p0

    move v3, v11

    move v4, v12

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v1

    invoke-virtual {v13, v1, v2}, Lchat/ola/vn/entity/t;->e(J)V

    const/16 v2, 0x22

    move-object v1, p0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v1

    invoke-virtual {v13, v1, v2}, Lchat/ola/vn/entity/t;->d(J)V

    invoke-interface {v8, v13}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v10, v10, 0x1

    move v11, v12

    goto :goto_0

    :cond_0
    const/4 v8, 0x0

    :cond_1
    return-object v8
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 5

    :try_start_0
    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v0

    const v1, 0x7f0f001e

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/accounts/AccountManager;->getAccountsByType(Ljava/lang/String;)[Landroid/accounts/Account;

    move-result-object p0

    if-eqz p0, :cond_1

    array-length v1, p0

    if-lez v1, :cond_1

    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, p0, v2

    iget-object v4, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {p1, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-virtual {v0, v3}, Landroid/accounts/AccountManager;->clearPassword(Landroid/accounts/Account;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    :goto_1
    :try_start_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    invoke-virtual {p0, p1}, Lchat/ola/vn/e;->e(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method private static b(Ljava/io/File;Lchat/ola/vn/w/cg;)V
    .locals 3

    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    new-instance p0, Lchat/ola/vn/w/cg;

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lchat/ola/vn/w/cg;-><init>(S)V

    const-string v1, "3.0"

    const/4 v2, 0x1

    invoke-virtual {p0, v2, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {p1}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V

    return-void
.end method

.method private static b(Ljava/io/File;Ljava/util/List;)V
    .locals 17
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    move-object/from16 v0, p1

    new-instance v1, Ljava/io/FileOutputStream;

    move-object/from16 v2, p0

    invoke-direct {v1, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    new-instance v2, Lchat/ola/vn/w/cg;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Lchat/ola/vn/w/cg;-><init>(S)V

    const-string v4, "3.0"

    const/4 v5, 0x1

    invoke-virtual {v2, v5, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    if-eqz v0, :cond_c

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v4

    const/4 v8, 0x0

    :goto_0
    if-ge v8, v4, :cond_c

    invoke-interface {v0, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lchat/ola/vn/entry/b;

    invoke-virtual {v9}, Lchat/ola/vn/entry/b;->d()I

    move-result v10

    const/4 v11, 0x2

    if-ne v10, v11, :cond_0

    :goto_1
    move/from16 v16, v4

    const/4 v9, 0x0

    goto/16 :goto_6

    :cond_0
    iget-object v10, v9, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->l()Z

    move-result v11

    if-nez v11, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v11

    const/16 v12, 0xc

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v13

    invoke-virtual {v2, v12, v13, v14}, Lchat/ola/vn/w/cg;->a(SJ)V

    const/4 v12, 0x4

    if-eqz v11, :cond_2

    goto :goto_2

    :cond_2
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v11

    :goto_2
    invoke-virtual {v2, v12, v11}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v11, 0xd

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->h()S

    move-result v12

    int-to-byte v12, v12

    invoke-virtual {v2, v11, v12}, Lchat/ola/vn/w/cg;->a(SB)V

    const/16 v11, 0x8

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->o()S

    move-result v12

    int-to-byte v12, v12

    invoke-virtual {v2, v11, v12}, Lchat/ola/vn/w/cg;->a(SB)V

    const/16 v11, 0x1a

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->w()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v2, v11, v12}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->B()Lchat/ola/vn/entity/w;

    move-result-object v11

    const/16 v12, 0x9

    if-eqz v11, :cond_4

    invoke-virtual {v11}, Lchat/ola/vn/entity/w;->c()I

    move-result v13

    if-lez v13, :cond_3

    const/4 v13, 0x7

    invoke-virtual {v11}, Lchat/ola/vn/entity/w;->c()I

    move-result v11

    int-to-byte v11, v11

    invoke-virtual {v2, v13, v11}, Lchat/ola/vn/w/cg;->a(SB)V

    goto :goto_3

    :cond_3
    invoke-virtual {v11}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object v13

    invoke-static {v13}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v13

    if-nez v13, :cond_4

    invoke-virtual {v11}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v2, v12, v11}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/4 v11, 0x1

    goto :goto_4

    :cond_4
    :goto_3
    const/4 v11, 0x0

    :goto_4
    const/16 v13, 0xe

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->g()I

    move-result v14

    invoke-virtual {v2, v13, v14}, Lchat/ola/vn/w/cg;->a(SI)V

    const/16 v13, 0xf

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->f()I

    move-result v14

    invoke-virtual {v2, v13, v14}, Lchat/ola/vn/w/cg;->a(SI)V

    const/16 v13, 0x10

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->i()S

    move-result v14

    int-to-byte v14, v14

    invoke-virtual {v2, v13, v14}, Lchat/ola/vn/w/cg;->a(SB)V

    const/4 v13, 0x6

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->d()J

    move-result-wide v14

    move/from16 v16, v4

    sub-long v3, v6, v14

    invoke-virtual {v2, v13, v3, v4}, Lchat/ola/vn/w/cg;->a(SJ)V

    const/16 v3, 0x62

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->v()J

    move-result-wide v13

    invoke-virtual {v2, v3, v13, v14}, Lchat/ola/vn/w/cg;->a(SJ)V

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->z()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_5

    const/16 v3, 0x6c

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->z()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_5
    const/16 v3, 0x63

    :try_start_0
    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->x()Lchat/ola/vn/entity/h;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/entity/h;->a()J

    move-result-wide v13

    invoke-virtual {v2, v3, v13, v14}, Lchat/ola/vn/w/cg;->a(SJ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object v3

    if-nez v11, :cond_8

    invoke-virtual {v9}, Lchat/ola/vn/entry/b;->g()Ljava/util/List;

    move-result-object v4

    if-eqz v4, :cond_8

    invoke-interface {v4}, Ljava/util/List;->isEmpty()Z

    move-result v9

    if-nez v9, :cond_8

    const/4 v9, 0x0

    invoke-interface {v4, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    invoke-static {v11}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v13

    if-nez v13, :cond_6

    invoke-virtual {v2, v12, v11}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_6
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v11

    move-object v12, v3

    const/4 v3, 0x1

    :goto_5
    if-ge v3, v11, :cond_9

    if-nez v12, :cond_7

    const-string v12, ""

    :cond_7
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v12, " #\u001b"

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {v4, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v12, "#"

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    add-int/lit8 v3, v3, 0x1

    goto :goto_5

    :cond_8
    const/4 v9, 0x0

    move-object v12, v3

    :cond_9
    invoke-static {v12}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_a

    const/4 v3, 0x5

    invoke-virtual {v2, v3, v12}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_a
    const/16 v3, 0x11

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->k()S

    move-result v4

    int-to-byte v4, v4

    invoke-virtual {v2, v3, v4}, Lchat/ola/vn/w/cg;->a(SB)V

    const/16 v3, 0x12

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->j()Z

    move-result v4

    int-to-byte v4, v4

    invoke-virtual {v2, v3, v4}, Lchat/ola/vn/w/cg;->a(SB)V

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->q()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_b

    const/16 v3, 0x52

    invoke-virtual {v10}, Lchat/ola/vn/entity/g;->q()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_b
    :goto_6
    add-int/lit8 v8, v8, 0x1

    move/from16 v4, v16

    const/4 v3, 0x0

    goto/16 :goto_0

    :cond_c
    invoke-virtual {v2}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V

    return-void
.end method

.method private static b(Ljava/io/File;Ljava/util/List;I)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;I)V"
        }
    .end annotation

    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    new-instance p0, Lchat/ola/vn/w/cg;

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lchat/ola/vn/w/cg;-><init>(S)V

    const-string v2, "3.0"

    const/4 v3, 0x1

    invoke-virtual {p0, v3, v2}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v2, 0x16

    invoke-virtual {p0, v2, p2}, Lchat/ola/vn/w/cg;->a(SI)V

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p2

    :goto_0
    if-ge v1, p2, :cond_1

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/message/f;

    const/4 v4, 0x7

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v4, v5}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v2, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v4, 0xc

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->g()S

    move-result v5

    int-to-byte v5, v5

    invoke-virtual {p0, v4, v5}, Lchat/ola/vn/w/cg;->a(SB)V

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_0

    const/16 v5, 0xd

    invoke-virtual {p0, v5, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    const/16 v4, 0x2d

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->i()S

    move-result v5

    int-to-byte v5, v5

    invoke-virtual {p0, v4, v5}, Lchat/ola/vn/w/cg;->a(SB)V

    const/16 v4, 0x26

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->h()S

    move-result v3

    int-to-byte v3, v3

    invoke-virtual {p0, v4, v3}, Lchat/ola/vn/w/cg;->a(SB)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V

    return-void
.end method

.method public static b(Ljava/lang/String;)V
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$18;

    invoke-direct {v0, p0}, Lchat/ola/vn/h/b$18;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 v1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v1, v1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, v1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, v1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b(Ljava/lang/String;B)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$3;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$3;-><init>(Ljava/lang/String;B)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b(Ljava/lang/String;Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$13;

    invoke-direct {v0, p1, p0}, Lchat/ola/vn/h/b$13;-><init>(Ljava/util/List;Ljava/lang/String;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static b(Ljava/lang/String;SLjava/lang/String;)V
    .locals 9

    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/w/cg;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lchat/ola/vn/w/cg;-><init>(S)V

    if-nez v0, :cond_0

    :goto_0
    invoke-virtual {v1, p1, p2}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    goto :goto_3

    :cond_0
    invoke-virtual {v0}, Lchat/ola/vn/w/s;->a()I

    move-result v3

    const/4 v4, 0x1

    const/4 v5, 0x0

    const/4 v6, 0x1

    :goto_1
    if-ge v5, v3, :cond_3

    invoke-virtual {v0, v5}, Lchat/ola/vn/w/s;->a(I)Ljava/lang/Short;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Short;->shortValue()S

    move-result v8

    if-ne v8, v4, :cond_1

    goto :goto_2

    :cond_1
    invoke-virtual {v7}, Ljava/lang/Short;->shortValue()S

    move-result v8

    if-ne v8, p1, :cond_2

    invoke-virtual {v1, p1, p2}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/4 v6, 0x0

    goto :goto_2

    :cond_2
    invoke-virtual {v7}, Ljava/lang/Short;->shortValue()S

    move-result v7

    invoke-virtual {v0, v5}, Lchat/ola/vn/w/s;->b(I)[B

    move-result-object v8

    invoke-virtual {v1, v7, v8}, Lchat/ola/vn/w/cg;->a(S[B)V

    :goto_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    :cond_3
    if-eqz v6, :cond_4

    goto :goto_0

    :cond_4
    :goto_3
    invoke-static {p0, v1}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Lchat/ola/vn/w/cg;)V

    return-void
.end method

.method public static b(Ljava/lang/String;Z)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$4;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$4;-><init>(Ljava/lang/String;Z)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b(Ljava/lang/String;[B)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$1;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$1;-><init>(Ljava/lang/String;[B)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static b(SLjava/lang/String;)V
    .locals 9

    invoke-static {}, Lchat/ola/vn/h/b;->h()Lchat/ola/vn/w/s;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/w/cg;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lchat/ola/vn/w/cg;-><init>(S)V

    if-nez v0, :cond_0

    :goto_0
    invoke-virtual {v1, p0, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    goto :goto_3

    :cond_0
    invoke-virtual {v0}, Lchat/ola/vn/w/s;->a()I

    move-result v3

    const/4 v4, 0x1

    const/4 v5, 0x0

    const/4 v6, 0x1

    :goto_1
    if-ge v5, v3, :cond_3

    invoke-virtual {v0, v5}, Lchat/ola/vn/w/s;->a(I)Ljava/lang/Short;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Short;->shortValue()S

    move-result v8

    if-ne v8, v4, :cond_1

    goto :goto_2

    :cond_1
    invoke-virtual {v7}, Ljava/lang/Short;->shortValue()S

    move-result v8

    if-ne v8, p0, :cond_2

    invoke-virtual {v1, p0, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/4 v6, 0x0

    goto :goto_2

    :cond_2
    invoke-virtual {v7}, Ljava/lang/Short;->shortValue()S

    move-result v7

    invoke-virtual {v0, v5}, Lchat/ola/vn/w/s;->b(I)[B

    move-result-object v8

    invoke-virtual {v1, v7, v8}, Lchat/ola/vn/w/cg;->a(S[B)V

    :goto_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    :cond_3
    if-eqz v6, :cond_4

    goto :goto_0

    :cond_4
    :goto_3
    invoke-static {v1}, Lchat/ola/vn/h/b;->a(Lchat/ola/vn/w/cg;)V

    return-void
.end method

.method private static b(Lchat/ola/vn/w/s;)Z
    .locals 3

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    const/4 v1, 0x0

    if-nez p0, :cond_0

    return v1

    :cond_0
    const-string v2, "3.0"

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_2

    invoke-static {}, Lchat/ola/vn/d;->f()Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_1

    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v2, ".systemme.info"

    invoke-direct {v0, p0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_1

    invoke-static {v0}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    :cond_1
    return v1

    :cond_2
    return v0
.end method

.method private static b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z
    .locals 3

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    const-string v2, "3.0"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_1

    new-instance p1, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v0, ".info.dat"

    invoke-direct {p1, p0, v0}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_1

    invoke-static {p1}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    :cond_1
    return v1

    :cond_2
    return v0
.end method

.method public static b(Ljava/util/List;)[B
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/g;",
            ">;)[B"
        }
    .end annotation

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0x64

    if-le v0, v1, :cond_0

    const/16 v0, 0x64

    :cond_0
    new-instance v1, Lchat/ola/vn/w/cg;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lchat/ola/vn/w/cg;-><init>(S)V

    :goto_0
    if-ge v2, v0, :cond_4

    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entry/g;

    const/16 v4, 0x1e

    invoke-virtual {v3}, Lchat/ola/vn/entry/g;->a()Ljava/lang/String;

    move-result-object v5

    if-nez v5, :cond_1

    const-string v5, "null"

    goto :goto_1

    :cond_1
    invoke-virtual {v3}, Lchat/ola/vn/entry/g;->a()Ljava/lang/String;

    move-result-object v5

    :goto_1
    invoke-virtual {v1, v4, v5}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    invoke-virtual {v3}, Lchat/ola/vn/entry/g;->b()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_2

    const/16 v5, 0x1f

    invoke-virtual {v1, v5, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    invoke-virtual {v3}, Lchat/ola/vn/entry/g;->e()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_3

    const/16 v5, 0x2c

    invoke-virtual {v1, v5, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_3
    const/16 v4, 0x2a

    invoke-virtual {v3}, Lchat/ola/vn/entry/g;->c()J

    move-result-wide v5

    invoke-virtual {v1, v4, v5, v6}, Lchat/ola/vn/w/cg;->a(SJ)V

    const/16 v4, 0x2b

    invoke-virtual {v3}, Lchat/ola/vn/entry/g;->d()J

    move-result-wide v5

    invoke-virtual {v1, v4, v5, v6}, Lchat/ola/vn/w/cg;->a(SJ)V

    const/16 v4, 0x22

    invoke-virtual {v3}, Lchat/ola/vn/entry/g;->f()J

    move-result-wide v5

    invoke-virtual {v1, v4, v5, v6}, Lchat/ola/vn/w/cg;->a(SJ)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_4
    invoke-virtual {v1}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static c()Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h/b;->h()Lchat/ola/vn/w/s;

    move-result-object v1

    if-nez v1, :cond_0

    return-object v0

    :cond_0
    invoke-static {v1}, Lchat/ola/vn/h/b;->a(Lchat/ola/vn/w/s;)Z

    move-result v2

    if-eqz v2, :cond_1

    const/16 v2, 0x50

    invoke-virtual {v1, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    :cond_1
    return-object v0
.end method

.method public static c(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 6

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v0

    const v2, 0x7f0f001e

    invoke-virtual {p0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/accounts/AccountManager;->getAccountsByType(Ljava/lang/String;)[Landroid/accounts/Account;

    move-result-object p0

    if-eqz p0, :cond_2

    array-length v2, p0

    if-lez v2, :cond_2

    array-length v2, p0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, p0, v3

    iget-object v5, v4, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v5, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-virtual {v0, v4}, Landroid/accounts/AccountManager;->getPassword(Landroid/accounts/Account;)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, p0

    goto :goto_1

    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :catch_0
    :cond_2
    :goto_1
    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_3

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    invoke-virtual {p0, p1}, Lchat/ola/vn/e;->m(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :cond_3
    return-object v1
.end method

.method private static c(Lchat/ola/vn/w/s;)Ljava/util/List;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/w/s;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    const/16 v0, 0x19

    invoke-virtual {p0, v0}, Lchat/ola/vn/w/s;->c(S)I

    move-result v0

    if-lez v0, :cond_1

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v2, 0x7

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v4

    move v5, v4

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v0, :cond_2

    invoke-virtual {p0, v2, v5}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v6

    invoke-virtual {p0, v5}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v7

    new-instance v8, Lchat/ola/vn/message/f;

    invoke-direct {v8, v7, v3}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    const/16 v9, 0x16

    invoke-virtual {p0, v9, v5, v6}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v9

    if-nez v9, :cond_0

    goto :goto_1

    :cond_0
    move-object v7, v9

    :goto_1
    invoke-virtual {v8, v7}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    const/16 v7, 0xc

    invoke-virtual {p0, v7, v5, v6, v3}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v7

    int-to-short v7, v7

    invoke-virtual {v8, v7}, Lchat/ola/vn/message/f;->b(S)V

    const/16 v7, 0xd

    invoke-virtual {p0, v7, v5, v6}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v8, v7}, Lchat/ola/vn/message/f;->e(Ljava/lang/String;)V

    const/16 v7, 0x2d

    invoke-virtual {p0, v7, v5, v6, v3}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v7

    int-to-short v7, v7

    invoke-virtual {v8, v7}, Lchat/ola/vn/message/f;->e(S)V

    const/16 v7, 0x26

    invoke-virtual {p0, v7, v5, v6, v3}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v5

    int-to-short v5, v5

    invoke-virtual {v8, v5}, Lchat/ola/vn/message/f;->c(S)V

    const/4 v5, 0x1

    invoke-virtual {v8, v5}, Lchat/ola/vn/message/f;->b(B)V

    invoke-interface {v1, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    move v5, v6

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :cond_2
    return-object v1
.end method

.method public static c([B)Ljava/util/List;
    .locals 19
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/io/ByteArrayInputStream;

    move-object/from16 v2, p0

    invoke-direct {v1, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-static {v1}, Lchat/ola/vn/util/o;->a(Ljava/io/InputStream;)Lchat/ola/vn/w/s;

    move-result-object v1

    const/4 v8, 0x2

    invoke-virtual {v1, v8}, Lchat/ola/vn/w/s;->c(S)I

    move-result v9

    if-lez v9, :cond_3

    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10, v9}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v11, 0x0

    invoke-virtual {v1, v8, v11}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    move v13, v2

    const/4 v12, 0x0

    :goto_0
    if-ge v12, v9, :cond_2

    invoke-virtual {v1, v8, v13}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v14

    invoke-virtual {v1, v13}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v15

    const/16 v2, 0x55

    invoke-virtual {v1, v2, v13, v14, v11}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v2

    int-to-short v6, v2

    const/16 v3, 0x2e

    const-wide/16 v16, 0x0

    move-object v2, v1

    move v4, v13

    move v5, v14

    move v8, v6

    move-wide/from16 v6, v16

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v2

    new-instance v4, Lchat/ola/vn/message/f;

    invoke-direct {v4, v15, v8}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->m()Z

    move-result v5

    if-nez v5, :cond_0

    goto :goto_2

    :cond_0
    const-wide/16 v5, 0x0

    iput-wide v5, v4, Lchat/ola/vn/message/f;->M:J

    cmp-long v7, v2, v5

    if-lez v7, :cond_1

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    iput-object v2, v4, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    goto :goto_1

    :cond_1
    iput-object v0, v4, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    :goto_1
    invoke-virtual {v4, v11}, Lchat/ola/vn/message/f;->a(I)V

    const/4 v2, 0x1

    invoke-virtual {v4, v2, v11}, Lchat/ola/vn/message/f;->a(ZZ)V

    invoke-interface {v10, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move v13, v14

    :goto_2
    add-int/lit8 v12, v12, 0x1

    const/4 v8, 0x2

    goto :goto_0

    :cond_2
    return-object v10

    :catch_0
    :cond_3
    return-object v0
.end method

.method private static c(Ljava/io/File;Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/af;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    new-instance p0, Lchat/ola/vn/w/cg;

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lchat/ola/vn/w/cg;-><init>(S)V

    const-string v1, "3.0"

    const/4 v2, 0x1

    invoke-virtual {p0, v2, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/af;

    const/16 v2, 0x19

    invoke-virtual {v1}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v2, 0x1a

    invoke-virtual {v1}, Lchat/ola/vn/entity/af;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v2, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V

    return-void
.end method

.method public static c(Ljava/lang/String;B)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$5;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$5;-><init>(Ljava/lang/String;B)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static c(Ljava/lang/String;Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$14;

    invoke-direct {v0, p1, p0}, Lchat/ola/vn/h/b$14;-><init>(Ljava/util/List;Ljava/lang/String;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static c(Ljava/lang/String;Z)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$6;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$6;-><init>(Ljava/lang/String;Z)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static c(Ljava/lang/String;Lchat/ola/vn/w/s;)Z
    .locals 3

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    const-string v2, "2.0"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_1

    new-instance p1, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v0, ".info.dat"

    invoke-direct {p1, p0, v0}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_1

    invoke-static {p1}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    :cond_1
    return v1

    :cond_2
    return v0
.end method

.method public static c(Ljava/lang/String;)[B
    .locals 3

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v2, ".app.background"

    invoke-direct {v0, p0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    :try_start_0
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p0

    if-nez p0, :cond_1

    return-object v1

    :cond_1
    invoke-static {v0}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;)[B

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_2
    return-object v1
.end method

.method public static c(Ljava/util/List;)[B
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;)[B"
        }
    .end annotation

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0x64

    if-le v0, v1, :cond_0

    const/16 v0, 0x64

    :cond_0
    new-instance v1, Lchat/ola/vn/w/cg;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lchat/ola/vn/w/cg;-><init>(S)V

    :goto_0
    if-ge v2, v0, :cond_3

    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/t;

    const/16 v4, 0x1e

    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v5

    if-nez v5, :cond_1

    const-string v5, "null"

    goto :goto_1

    :cond_1
    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v5

    :goto_1
    invoke-virtual {v1, v4, v5}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->l()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_2

    const/16 v5, 0x1f

    invoke-virtual {v1, v5, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    const/16 v4, 0x2a

    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->A()J

    move-result-wide v5

    invoke-virtual {v1, v4, v5, v6}, Lchat/ola/vn/w/cg;->a(SJ)V

    const/16 v4, 0x2b

    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->z()I

    move-result v5

    invoke-virtual {v1, v4, v5}, Lchat/ola/vn/w/cg;->a(SI)V

    const/16 v4, 0x22

    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->y()J

    move-result-wide v5

    invoke-virtual {v1, v4, v5, v6}, Lchat/ola/vn/w/cg;->a(SJ)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_3
    invoke-virtual {v1}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static d(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 6

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v0

    const v2, 0x7f0f001e

    invoke-virtual {p0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/accounts/AccountManager;->getAccountsByType(Ljava/lang/String;)[Landroid/accounts/Account;

    move-result-object p0

    if-eqz p0, :cond_2

    array-length v2, p0

    if-lez v2, :cond_2

    array-length v2, p0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, p0, v3

    iget-object v5, v4, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v5, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    const-string p0, "_trust_token"

    invoke-virtual {v0, v4, p0}, Landroid/accounts/AccountManager;->getUserData(Landroid/accounts/Account;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    return-object v1

    :catch_0
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    invoke-virtual {p0, p1}, Lchat/ola/vn/e;->n(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static d()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;"
        }
    .end annotation

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    const-string v1, "vipicon.dat"

    invoke-virtual {v0, v1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/InputStream;->available()I

    move-result v1

    new-array v1, v1, [B

    invoke-virtual {v0, v1}, Ljava/io/InputStream;->read([B)I

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    invoke-static {v1}, Lchat/ola/vn/entity/ah;->b([B)Ljava/util/List;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method private static d(Lchat/ola/vn/w/s;)Ljava/util/List;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/w/s;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    const/16 v0, 0x19

    invoke-virtual {p0, v0}, Lchat/ola/vn/w/s;->c(S)I

    move-result v1

    if-lez v1, :cond_0

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v3, 0x0

    invoke-virtual {p0, v0, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    :goto_0
    if-ge v3, v1, :cond_1

    invoke-virtual {p0, v0, v4}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v5

    invoke-virtual {p0, v4}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lchat/ola/vn/message/f;

    const/4 v8, 0x2

    invoke-direct {v7, v6, v8}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v7, v8}, Lchat/ola/vn/message/f;->a(S)V

    const/16 v6, 0x1a

    invoke-virtual {p0, v6, v4, v5}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v7, v6}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;)V

    const/16 v6, 0x26

    invoke-virtual {p0, v6, v4, v5}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v7, v6}, Lchat/ola/vn/message/f;->d(Ljava/lang/String;)V

    const/16 v6, 0x9

    invoke-virtual {p0, v6, v4, v5}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v7, v4}, Lchat/ola/vn/message/f;->g(Ljava/lang/String;)V

    invoke-interface {v2, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    move v4, v5

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :cond_1
    return-object v2
.end method

.method public static d(Ljava/lang/String;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->y(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return-object v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_2

    invoke-static {v0}, Lchat/ola/vn/h/b;->c(Lchat/ola/vn/w/s;)Ljava/util/List;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_2
    return-object v1
.end method

.method public static d([B)Ljava/util/List;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/io/ByteArrayInputStream;

    invoke-direct {v0, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-static {v0}, Lchat/ola/vn/util/o;->a(Ljava/io/InputStream;)Lchat/ola/vn/w/s;

    move-result-object p0

    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lchat/ola/vn/w/s;->c(S)I

    move-result v1

    if-lez v1, :cond_1

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v3, 0x0

    invoke-virtual {p0, v0, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    move v5, v4

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v1, :cond_0

    invoke-virtual {p0, v0, v5}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v6

    invoke-virtual {p0, v5}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v7

    const/16 v8, 0x55

    invoke-virtual {p0, v8, v5, v6, v3}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v8

    int-to-short v8, v8

    const/16 v9, 0x1c

    invoke-virtual {p0, v9, v5, v6}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v5

    new-instance v9, Lchat/ola/vn/message/f;

    invoke-direct {v9, v7, v8}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v9, v5}, Lchat/ola/vn/message/f;->h(Ljava/lang/String;)V

    invoke-interface {v2, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v4, v4, 0x1

    move v5, v6

    goto :goto_0

    :cond_0
    return-object v2

    :catch_0
    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static d(Ljava/lang/String;B)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$11;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$11;-><init>(Ljava/lang/String;B)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static d(Ljava/lang/String;Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_2

    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v1, ".chatgroup.dat"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    :try_start_0
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p0

    if-nez p0, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z

    :cond_1
    invoke-static {v0, p1}, Lchat/ola/vn/h/b;->a(Ljava/io/File;Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public static d(Ljava/lang/String;Z)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$8;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$8;-><init>(Ljava/lang/String;Z)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static d(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/af;",
            ">;)V"
        }
    .end annotation

    invoke-static {}, Lchat/ola/vn/d;->f()Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_1

    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    const-string v2, ".systemme.info"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    :try_start_0
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z

    :cond_0
    invoke-static {v1, p0}, Lchat/ola/vn/h/b;->c(Ljava/io/File;Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method private static d(Ljava/lang/String;Lchat/ola/vn/w/s;)Z
    .locals 3

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    const-string v2, "2.0"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_1

    new-instance p1, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v0, ".contact.dat"

    invoke-direct {p1, p0, v0}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_1

    invoke-static {p1}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    :cond_1
    return v1

    :cond_2
    return v0
.end method

.method public static e(Ljava/lang/String;)J
    .locals 5

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const-wide/16 v1, 0x0

    if-eqz v0, :cond_0

    return-wide v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return-wide v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_2

    const/16 p0, 0x61

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v3

    :catch_0
    :cond_2
    return-wide v1
.end method

.method public static e()Ljava/util/List;
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/af;",
            ">;"
        }
    .end annotation

    invoke-static {}, Lchat/ola/vn/d;->f()Ljava/io/File;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    new-instance v2, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    const-string v3, ".systemme.info"

    invoke-direct {v2, v0, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    :try_start_0
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_3

    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-static {v0}, Lchat/ola/vn/util/o;->a(Ljava/io/InputStream;)Lchat/ola/vn/w/s;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V

    if-nez v2, :cond_0

    return-object v1

    :cond_0
    invoke-static {v2}, Lchat/ola/vn/h/b;->b(Lchat/ola/vn/w/s;)Z

    move-result v0

    if-eqz v0, :cond_3

    const/16 v0, 0x19

    invoke-virtual {v2, v0}, Lchat/ola/vn/w/s;->c(S)I

    move-result v3

    if-lez v3, :cond_3

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    const/4 v5, 0x0

    invoke-virtual {v2, v0, v5}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v6

    const/16 v7, 0x1a

    invoke-virtual {v2, v7, v5}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v8

    :goto_0
    if-ge v5, v3, :cond_2

    invoke-virtual {v2, v6}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v9

    const-string v10, "#sh"

    invoke-static {v10, v9}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_1

    goto :goto_1

    :cond_1
    new-instance v10, Lchat/ola/vn/entity/af;

    invoke-virtual {v2, v8}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v11

    invoke-direct {v10, v11, v9}, Lchat/ola/vn/entity/af;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v4, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v2, v0, v6}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v6

    invoke-virtual {v2, v7, v8}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v8
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_2
    return-object v4

    :catch_0
    :cond_3
    return-object v1
.end method

.method public static e(Ljava/lang/String;Z)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$9;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$9;-><init>(Ljava/lang/String;Z)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static e(Ljava/lang/String;Lchat/ola/vn/w/s;)Z
    .locals 3

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    const-string v2, "3.0"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_1

    new-instance p1, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v0, ".chatgroup.dat"

    invoke-direct {p1, p0, v0}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_1

    invoke-static {p1}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    :cond_1
    return v1

    :cond_2
    return v0
.end method

.method public static e(Ljava/util/List;)[B
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)[B"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v1

    const/16 v2, 0x3c

    if-le v1, v2, :cond_0

    const/16 v1, 0x3c

    :cond_0
    const/4 v2, 0x0

    move-object v4, v0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_4

    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/message/f;

    invoke-virtual {v5}, Lchat/ola/vn/message/f;->m()Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-virtual {v5}, Lchat/ola/vn/message/f;->V()Z

    move-result v6

    if-nez v6, :cond_1

    goto :goto_1

    :cond_1
    if-nez v4, :cond_2

    new-instance v4, Lchat/ola/vn/w/cg;

    invoke-direct {v4, v2}, Lchat/ola/vn/w/cg;-><init>(S)V

    :cond_2
    const/4 v6, 0x2

    invoke-virtual {v5}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v6, 0x55

    invoke-virtual {v5}, Lchat/ola/vn/message/f;->k()S

    move-result v7

    int-to-byte v7, v7

    invoke-virtual {v4, v6, v7}, Lchat/ola/vn/w/cg;->a(SB)V

    const/4 v6, 0x6

    invoke-virtual {v5}, Lchat/ola/vn/message/f;->a()J

    move-result-wide v7

    invoke-virtual {v4, v6, v7, v8}, Lchat/ola/vn/w/cg;->a(SJ)V

    iget-object v6, v5, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    if-eqz v6, :cond_3

    const/16 v6, 0x2e

    iget-object v5, v5, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    invoke-virtual {v5}, Ljava/lang/Long;->longValue()J

    move-result-wide v7

    invoke-virtual {v4, v6, v7, v8}, Lchat/ola/vn/w/cg;->a(SJ)V

    :cond_3
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_4
    if-eqz v4, :cond_5

    invoke-virtual {v4}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_5
    return-object v0
.end method

.method public static f(Ljava/lang/String;)Ljava/lang/Long;
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return-object v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_2

    const/16 p0, 0x58

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_2
    return-object v1
.end method

.method public static f(Ljava/lang/String;Z)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/h/b$10;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/h/b$10;-><init>(Ljava/lang/String;Z)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p0

    const/4 p1, 0x0

    if-eqz p0, :cond_1

    sget-object p0, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0, p1}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array p0, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static f(Ljava/lang/String;Lchat/ola/vn/w/s;)Z
    .locals 3

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    const-string v2, "3.0"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_1

    new-instance p1, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v0, ".lastviewme.dat"

    invoke-direct {p1, p0, v0}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_1

    invoke-static {p1}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    :cond_1
    return v1

    :cond_2
    return v0
.end method

.method public static f()[B
    .locals 4

    :try_start_0
    new-instance v0, Lchat/ola/vn/w/cg;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lchat/ola/vn/w/cg;-><init>(S)V

    const/16 v2, 0x38

    sget-byte v3, Lchat/ola/vn/c/x;->k:B

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v2, 0x6b

    sget-boolean v3, Lchat/ola/vn/c/x;->u:Z

    invoke-static {v3}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v2, 0x56

    sget-byte v3, Lchat/ola/vn/c/x;->l:B

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v2, 0x5a

    invoke-static {v1}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v2, 0x5b

    sget-boolean v3, Lchat/ola/vn/c/x;->r:Z

    invoke-static {v3}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v2, 0x5f

    sget-boolean v3, Lchat/ola/vn/c/x;->s:Z

    invoke-static {v3}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v2, 0x65

    sget-byte v3, Lchat/ola/vn/c/x;->p:B

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v2, 0x68

    sget-boolean v3, Lchat/ola/vn/c/x;->t:Z

    invoke-static {v3}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v2, 0x13

    invoke-static {v1}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    sget-object v2, Lchat/ola/vn/c/x;->b:Ljava/lang/Boolean;

    const/16 v3, 0x69

    if-eqz v2, :cond_0

    sget-object v1, Lchat/ola/vn/c/x;->b:Ljava/lang/Boolean;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v3, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    goto :goto_1

    :cond_0
    invoke-static {v1}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :goto_1
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public static f(Ljava/util/List;)[B
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)[B"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x0

    move-object v4, v0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_2

    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/message/f;

    invoke-virtual {v5}, Lchat/ola/vn/message/f;->p()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_0

    goto :goto_1

    :cond_0
    if-nez v4, :cond_1

    new-instance v4, Lchat/ola/vn/w/cg;

    invoke-direct {v4, v2}, Lchat/ola/vn/w/cg;-><init>(S)V

    :cond_1
    const/4 v7, 0x2

    invoke-virtual {v5}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4, v7, v8}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v7, 0x55

    invoke-virtual {v5}, Lchat/ola/vn/message/f;->k()S

    move-result v5

    int-to-byte v5, v5

    invoke-virtual {v4, v7, v5}, Lchat/ola/vn/w/cg;->a(SB)V

    const/16 v5, 0x1c

    invoke-virtual {v4, v5, v6}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    if-eqz v4, :cond_3

    invoke-virtual {v4}, Lchat/ola/vn/w/cg;->a()[B

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    return-object v0
.end method

.method public static g(Ljava/lang/String;)B
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/h/b;->i()B

    move-result p0

    return p0

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/h/b;->i()B

    move-result p0

    return p0

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_3

    const/16 p0, 0x3b

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/h/b;->i()B

    move-result p0

    return p0

    :cond_2
    invoke-static {p0}, Ljava/lang/Byte;->parseByte(Ljava/lang/String;)B

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    :cond_3
    invoke-static {}, Lchat/ola/vn/h/b;->i()B

    move-result p0

    return p0
.end method

.method public static g()V
    .locals 12

    const/4 v0, 0x1

    :try_start_0
    sget-boolean v1, Lchat/ola/vn/h/b;->a:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    sput-boolean v0, Lchat/ola/vn/h/b;->a:Z

    return-void

    :cond_0
    :try_start_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/e;->b()I

    move-result v1

    const/16 v2, 0x58

    if-le v1, v2, :cond_1

    sput-boolean v0, Lchat/ola/vn/h/b;->a:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    sput-boolean v0, Lchat/ola/vn/h/b;->a:Z

    return-void

    :cond_1
    :try_start_2
    invoke-static {}, Lchat/ola/vn/d;->j()Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_4

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-virtual {v1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_4

    const-string v2, "."

    const/4 v3, 0x0

    :goto_0
    array-length v4, v1

    if-ge v3, v4, :cond_4

    aget-object v4, v1, v3

    if-eqz v4, :cond_3

    aget-object v4, v1, v3

    invoke-virtual {v4}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-eqz v4, :cond_3

    aget-object v4, v1, v3

    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_3

    invoke-virtual {v4, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v6

    if-le v5, v6, :cond_3

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_3

    invoke-static {v4}, Lchat/ola/vn/h/b;->w(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v4}, Lchat/ola/vn/h/b;->x(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v4}, Lchat/ola/vn/h/b;->e(Ljava/lang/String;)J

    move-result-wide v7
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v9

    invoke-static {v9}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v9

    new-instance v10, Landroid/accounts/Account;

    const v11, 0x7f0f001e

    invoke-static {v11}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v11

    invoke-direct {v10, v4, v11}, Landroid/accounts/Account;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v4, 0x0

    invoke-virtual {v9, v10, v5, v4}, Landroid/accounts/AccountManager;->addAccountExplicitly(Landroid/accounts/Account;Ljava/lang/String;Landroid/os/Bundle;)Z

    move-result v4

    if-eqz v4, :cond_2

    const v4, 0x7f0f06e9

    invoke-static {v4}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v9, v10, v4, v6}, Landroid/accounts/AccountManager;->setAuthToken(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;)V

    const-string v4, "_time"

    invoke-static {v7, v8}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v9, v10, v4, v5}, Landroid/accounts/AccountManager;->setUserData(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    :cond_2
    invoke-virtual {v9, v10, v5}, Landroid/accounts/AccountManager;->setPassword(Landroid/accounts/Account;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    :catch_0
    move-exception v4

    :try_start_4
    invoke-virtual {v4}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :cond_3
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :catchall_0
    move-exception v1

    sput-boolean v0, Lchat/ola/vn/h/b;->a:Z

    throw v1

    :catch_1
    :cond_4
    sput-boolean v0, Lchat/ola/vn/h/b;->a:Z

    return-void
.end method

.method public static h(Ljava/lang/String;)B
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_4

    const/16 p0, 0x38

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return v1

    :cond_2
    invoke-static {p0}, Ljava/lang/Byte;->parseByte(Ljava/lang/String;)B

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x2

    if-le p0, v0, :cond_3

    const/4 p0, 0x0

    :cond_3
    return p0

    :catch_0
    :cond_4
    return v1
.end method

.method private static h()Lchat/ola/vn/w/s;
    .locals 4

    const-string v0, ".app2.info"

    monitor-enter v0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/d;->f()Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_0

    new-instance v2, Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    const-string v3, ".app2.info"

    invoke-direct {v2, v1, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-static {v1}, Lchat/ola/vn/util/o;->a(Ljava/io/InputStream;)Lchat/ola/vn/w/s;

    move-result-object v2

    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    monitor-exit v0

    return-object v2

    :catch_0
    :cond_0
    monitor-exit v0

    const/4 v0, 0x0

    return-object v0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method

.method private static i()B
    .locals 1

    const/4 v0, 0x2

    return v0
.end method

.method public static i(Ljava/lang/String;)Z
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_3

    const/16 p0, 0x59

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return v1

    :cond_2
    invoke-static {p0}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    :cond_3
    return v1
.end method

.method public static j(Ljava/lang/String;)B
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x3

    if-eqz v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_3

    const/16 p0, 0x3f

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return v1

    :cond_2
    invoke-static {p0}, Ljava/lang/Byte;->parseByte(Ljava/lang/String;)B

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    :cond_3
    return v1
.end method

.method public static k(Ljava/lang/String;)Z
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_3

    const/16 p0, 0x43

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return v1

    :cond_2
    invoke-static {p0}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    :cond_3
    return v1
.end method

.method public static l(Ljava/lang/String;)Z
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_3

    const/16 p0, 0x6e

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return v1

    :cond_2
    invoke-static {p0}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    :cond_3
    return v1
.end method

.method public static m(Ljava/lang/String;)Z
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_3

    const/16 p0, 0x70

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return v1

    :cond_2
    invoke-static {p0}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    :cond_3
    return v1
.end method

.method public static n(Ljava/lang/String;)B
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_3

    const/16 p0, 0x40

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return v1

    :cond_2
    invoke-static {p0}, Ljava/lang/Byte;->parseByte(Ljava/lang/String;)B

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    :cond_3
    return v1
.end method

.method public static o(Ljava/lang/String;)Z
    .locals 0

    const/4 p0, 0x0

    return p0
.end method

.method public static p(Ljava/lang/String;)Ljava/util/List;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return-object v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_6

    const/16 p0, 0x51

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return-object v1

    :cond_2
    const-string v0, ";"

    invoke-virtual {p0, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_6

    array-length v0, p0

    if-nez v0, :cond_3

    return-object v1

    :cond_3
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    array-length v3, p0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_5

    aget-object v5, p0, v4

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    if-nez v6, :cond_4

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-interface {v2, v5, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_5
    return-object v0

    :catch_0
    :cond_6
    return-object v1
.end method

.method public static q(Ljava/lang/String;)Z
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_3

    const/16 p0, 0x41

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return v1

    :cond_2
    invoke-static {p0}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    :cond_3
    return v1
.end method

.method public static r(Ljava/lang/String;)Lchat/ola/vn/me/a;
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->z(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return-object v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_2

    const/16 p0, 0x6f

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/me/a;->a(Ljava/lang/String;)Lchat/ola/vn/me/a;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_2
    return-object v1
.end method

.method public static s(Ljava/lang/String;)Ljava/util/List;
    .locals 36
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;"
        }
    .end annotation

    invoke-static/range {p0 .. p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    return-object v2

    :cond_0
    invoke-virtual/range {p0 .. p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_e

    new-instance v3, Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    const-string v4, ".me"

    invoke-direct {v3, v1, v4}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_e

    new-instance v1, Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    const-string v4, ".lastviewme.dat"

    invoke-direct {v1, v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_e

    :try_start_0
    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-static {v3}, Lchat/ola/vn/util/o;->a(Ljava/io/InputStream;)Lchat/ola/vn/w/s;

    move-result-object v1

    invoke-virtual {v3}, Ljava/io/FileInputStream;->close()V

    if-nez v1, :cond_1

    return-object v2

    :cond_1
    move-object/from16 v3, p0

    invoke-static {v3, v1}, Lchat/ola/vn/h/b;->f(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result v3

    if-nez v3, :cond_2

    return-object v2

    :cond_2
    const/16 v3, 0xc

    invoke-virtual {v1, v3}, Lchat/ola/vn/w/s;->c(S)I

    move-result v10

    if-lez v10, :cond_d

    new-instance v11, Ljava/util/ArrayList;

    invoke-direct {v11, v10}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v12, 0x0

    invoke-virtual {v1, v3, v12}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v13

    move v8, v4

    const/4 v15, 0x0

    move-object v4, v2

    :goto_0
    if-ge v15, v10, :cond_b

    invoke-virtual {v1, v3, v8}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v9

    const-wide/16 v6, 0x0

    invoke-virtual {v1, v8, v6, v7}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v2

    if-nez v4, :cond_3

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    :cond_3
    move-object v5, v4

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, ""

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v5, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v4, 0x4

    invoke-virtual {v1, v4, v8, v9}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v7

    const/16 v4, 0xd

    invoke-virtual {v1, v4, v8, v9, v12}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v4

    int-to-short v6, v4

    const/4 v4, 0x7

    invoke-virtual {v1, v4, v8, v9, v12}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v4

    int-to-short v4, v4

    move/from16 v19, v4

    const/16 v4, 0x8

    invoke-virtual {v1, v4, v8, v9, v12}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v4

    int-to-short v4, v4

    const/16 v12, 0x1a

    invoke-virtual {v1, v12, v8, v9}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v12

    move/from16 v20, v4

    const/16 v4, 0xe

    move-object/from16 v21, v5

    const/4 v5, 0x0

    invoke-virtual {v1, v4, v8, v9, v5}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v4

    const/4 v5, 0x6

    const-wide/16 v22, 0x0

    move/from16 v24, v10

    move-object/from16 v26, v11

    move/from16 v25, v15

    move/from16 v10, v19

    move/from16 v15, v20

    move v11, v4

    move-object v4, v1

    move-object/from16 v19, v21

    move/from16 v27, v6

    const-wide/16 v17, 0x0

    move v6, v8

    move-object/from16 v28, v7

    move v7, v9

    move/from16 v29, v8

    move/from16 v30, v9

    move-wide/from16 v8, v22

    invoke-virtual/range {v4 .. v9}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v20

    const/16 v5, 0x62

    const-wide/16 v8, 0x0

    move-object v4, v1

    move/from16 v6, v29

    move/from16 v7, v30

    invoke-virtual/range {v4 .. v9}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v8

    const/16 v5, 0x63

    const-wide/16 v22, 0x0

    move-object v4, v1

    move/from16 v6, v29

    move/from16 v7, v30

    move-wide/from16 v31, v8

    move-wide/from16 v8, v22

    invoke-virtual/range {v4 .. v9}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v4

    const/4 v6, 0x5

    move/from16 v7, v29

    move/from16 v8, v30

    invoke-virtual {v1, v6, v7, v8}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v6

    const/16 v9, 0x9

    invoke-virtual {v1, v9, v7, v8}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v9

    move-wide/from16 v33, v4

    const/16 v4, 0x11

    const/4 v5, 0x0

    invoke-virtual {v1, v4, v7, v8, v5}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v4

    int-to-short v4, v4

    const/16 v5, 0x6c

    invoke-virtual {v1, v5, v7, v8}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v5

    invoke-static {v4}, Lchat/ola/vn/entity/g;->a(S)Z

    move-result v22

    if-nez v22, :cond_4

    :goto_1
    move-object/from16 v2, v26

    goto/16 :goto_4

    :cond_4
    move-object/from16 v35, v5

    const/16 v5, 0x52

    invoke-virtual {v1, v5, v7, v8}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v5

    if-nez v6, :cond_5

    if-nez v10, :cond_5

    if-nez v9, :cond_5

    goto :goto_1

    :cond_5
    new-instance v7, Lchat/ola/vn/entity/g;

    invoke-direct {v7}, Lchat/ola/vn/entity/g;-><init>()V

    invoke-virtual {v7, v2, v3}, Lchat/ola/vn/entity/g;->b(J)V

    move-object/from16 v2, v28

    invoke-virtual {v7, v2}, Lchat/ola/vn/entity/g;->a(Ljava/lang/String;)V

    invoke-virtual {v7, v11}, Lchat/ola/vn/entity/g;->b(I)V

    move/from16 v2, v27

    invoke-virtual {v7, v2}, Lchat/ola/vn/entity/g;->b(S)V

    if-lez v10, :cond_6

    new-instance v2, Lchat/ola/vn/entity/w;

    invoke-direct {v2}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {v2, v10}, Lchat/ola/vn/entity/w;->a(I)V

    goto :goto_2

    :cond_6
    invoke-static {v9}, Lchat/ola/vn/entity/w;->b(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_7

    new-instance v2, Lchat/ola/vn/entity/w;

    invoke-direct {v2}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {v2, v9}, Lchat/ola/vn/entity/w;->a(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto :goto_2

    :cond_7
    const/4 v2, 0x0

    :goto_2
    invoke-virtual {v7, v2}, Lchat/ola/vn/entity/g;->a(Lchat/ola/vn/entity/w;)V

    invoke-virtual {v7, v15}, Lchat/ola/vn/entity/g;->e(S)V

    invoke-virtual {v7, v12}, Lchat/ola/vn/entity/g;->i(Ljava/lang/String;)V

    const/4 v2, 0x0

    sub-long v2, v13, v20

    invoke-virtual {v7, v2, v3}, Lchat/ola/vn/entity/g;->a(J)V

    invoke-virtual {v7, v6}, Lchat/ola/vn/entity/g;->b(Ljava/lang/String;)V

    invoke-virtual {v7, v9}, Lchat/ola/vn/entity/g;->c(Ljava/lang/String;)V

    invoke-virtual {v7, v4}, Lchat/ola/vn/entity/g;->d(S)V

    move-wide/from16 v2, v31

    cmp-long v4, v2, v17

    if-nez v4, :cond_9

    invoke-static {v9}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    if-eqz v4, :cond_9

    :try_start_1
    invoke-static {v6}, Lchat/ola/vn/util/i;->e(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v9

    const/4 v10, 0x2

    if-nez v9, :cond_8

    invoke-virtual {v7, v10}, Lchat/ola/vn/entity/g;->d(S)V

    invoke-virtual {v7, v4}, Lchat/ola/vn/entity/g;->l(Ljava/lang/String;)V

    goto :goto_3

    :cond_8
    invoke-static {v6}, Lchat/ola/vn/util/i;->f(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_9

    invoke-virtual {v7, v10}, Lchat/ola/vn/entity/g;->d(S)V

    invoke-virtual {v7, v4}, Lchat/ola/vn/entity/g;->m(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_9
    :goto_3
    const/4 v4, 0x0

    :try_start_2
    invoke-virtual {v7, v4}, Lchat/ola/vn/entity/g;->a(Z)V

    invoke-virtual {v7, v5}, Lchat/ola/vn/entity/g;->f(Ljava/lang/String;)V

    invoke-virtual {v7, v2, v3}, Lchat/ola/vn/entity/g;->d(J)V

    move-object/from16 v2, v35

    invoke-virtual {v7, v2}, Lchat/ola/vn/entity/g;->k(Ljava/lang/String;)V

    cmp-long v2, v33, v17

    if-eqz v2, :cond_a

    new-instance v2, Lchat/ola/vn/entity/h;

    invoke-direct {v2}, Lchat/ola/vn/entity/h;-><init>()V

    move-wide/from16 v3, v33

    invoke-virtual {v2, v3, v4}, Lchat/ola/vn/entity/h;->a(J)V

    invoke-virtual {v7, v2}, Lchat/ola/vn/entity/g;->a(Lchat/ola/vn/entity/h;)V

    :cond_a
    move-object/from16 v2, v26

    invoke-interface {v2, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :goto_4
    add-int/lit8 v15, v25, 0x1

    move-object v11, v2

    move-object/from16 v4, v19

    move/from16 v10, v24

    const/4 v2, 0x0

    const/16 v3, 0xc

    const/4 v12, 0x0

    goto/16 :goto_0

    :cond_b
    move-object v2, v11

    new-instance v1, Lchat/ola/vn/e/c;

    const/4 v3, 0x0

    invoke-direct {v1, v3}, Lchat/ola/vn/e/c;-><init>(Z)V

    invoke-static {v2, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    invoke-static {v2}, Lchat/ola/vn/r/a/e;->e(Ljava/util/List;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/util/List;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    const/4 v1, 0x0

    :try_start_4
    invoke-static {v1}, Lchat/ola/vn/r/a/e;->d(Ljava/lang/String;)Lchat/ola/vn/entity/g;

    move-result-object v3

    if-eqz v3, :cond_c

    const/4 v1, 0x0

    invoke-interface {v2, v1, v3}, Ljava/util/List;->add(ILjava/lang/Object;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :cond_c
    move-object/from16 v16, v2

    return-object v16

    :cond_d
    const/16 v16, 0x0

    return-object v16

    :catch_2
    move-exception v0

    move-object v1, v0

    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 v1, 0x0

    return-object v1

    :cond_e
    move-object v1, v2

    return-object v1
.end method

.method public static t(Ljava/lang/String;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    const-string v0, ".conversation.list"

    monitor-enter v0

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_0

    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v2, ".conversation.list"

    invoke-direct {v1, p0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_0

    invoke-static {v1}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;)[B

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/h/b;->c([B)Ljava/util/List;

    move-result-object p0
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    monitor-exit v0

    return-object p0

    :catch_0
    :cond_0
    monitor-exit v0

    const/4 p0, 0x0

    return-object p0

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p0
.end method

.method public static u(Ljava/lang/String;)Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    const-string v0, ".phoneignore.list"

    monitor-enter v0

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_1

    new-instance v2, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v3, ".phoneignore.list"

    invoke-direct {v2, p0, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_1

    invoke-static {v2}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;)[B

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/h/b;->d([B)Ljava/util/List;

    move-result-object p0
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    monitor-exit v0

    return-object p0

    :catch_0
    :cond_1
    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p0
.end method

.method public static v(Ljava/lang/String;)Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_2

    new-instance v2, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    const-string v3, ".chatgroup.dat"

    invoke-direct {v2, v0, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    :try_start_0
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-static {v0}, Lchat/ola/vn/util/o;->a(Ljava/io/InputStream;)Lchat/ola/vn/w/s;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V

    if-nez v2, :cond_1

    return-object v1

    :cond_1
    invoke-static {p0, v2}, Lchat/ola/vn/h/b;->e(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_2

    invoke-static {v2}, Lchat/ola/vn/h/b;->d(Lchat/ola/vn/w/s;)Ljava/util/List;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_2
    return-object v1
.end method

.method public static w(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->A(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return-object v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->c(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_2

    const/16 p0, 0x31

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object p0

    if-eqz p0, :cond_2

    const/16 v2, 0x32

    invoke-virtual {v0, v2}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-static {p0, v0}, Lchat/ola/vn/j/a;->a([B[B)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_2
    return-object v1
.end method

.method public static x(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h/b;->A(Ljava/lang/String;)Lchat/ola/vn/w/s;

    move-result-object v0

    if-nez v0, :cond_1

    return-object v1

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->c(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0

    if-eqz p0, :cond_2

    const/16 p0, 0x1d

    invoke-virtual {v0, p0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_2
    return-object v1
.end method

.method private static y(Ljava/lang/String;)Lchat/ola/vn/w/s;
    .locals 3

    const-string v0, ".contact.dat"

    monitor-enter v0

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_0

    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    const-string v2, ".contact.dat"

    invoke-direct {v1, p0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_0

    new-instance p0, Ljava/io/FileInputStream;

    invoke-direct {p0, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-static {p0}, Lchat/ola/vn/util/o;->a(Ljava/io/InputStream;)Lchat/ola/vn/w/s;

    move-result-object v1

    invoke-virtual {p0}, Ljava/io/FileInputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    monitor-exit v0

    return-object v1

    :catch_0
    :cond_0
    monitor-exit v0

    const/4 p0, 0x0

    return-object p0

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p0
.end method

.method private static z(Ljava/lang/String;)Lchat/ola/vn/w/s;
    .locals 5

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    const-string v0, ".info.dat"

    monitor-enter v0

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_2

    new-instance v3, Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    const-string v4, ".info.dat"

    invoke-direct {v3, v2, v4}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_2

    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-static {v2}, Lchat/ola/vn/util/o;->a(Ljava/io/InputStream;)Lchat/ola/vn/w/s;

    move-result-object v3

    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez v3, :cond_1

    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    return-object v1

    :cond_1
    :try_start_3
    invoke-static {p0, v3}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Lchat/ola/vn/w/s;)Z

    move-result p0
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-eqz p0, :cond_2

    :try_start_4
    monitor-exit v0

    return-object v3

    :catch_0
    :cond_2
    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw p0
.end method
