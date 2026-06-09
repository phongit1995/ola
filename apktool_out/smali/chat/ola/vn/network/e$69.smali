.class Lchat/ola/vn/network/e$69;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->b(Ljava/util/List;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$69;->b:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$69;->a:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 14

    :try_start_0
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->setTimeInMillis(J)V

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v2

    const/4 v3, 0x2

    invoke-virtual {v0, v3}, Ljava/util/Calendar;->get(I)I

    move-result v4

    const/4 v5, 0x1

    invoke-virtual {v0, v5}, Ljava/util/Calendar;->get(I)I

    move-result v6

    const/4 v7, 0x0

    const-string v8, ""

    sget-object v9, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v10, p0, Lchat/ola/vn/network/e$69;->a:Ljava/util/List;

    invoke-virtual {v9, v10}, Lchat/ola/vn/message/g;->c(Ljava/util/List;)V

    iget-object v9, p0, Lchat/ola/vn/network/e$69;->a:Ljava/util/List;

    invoke-interface {v9}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :cond_0
    :goto_0
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_5

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lchat/ola/vn/message/f;

    sget-object v11, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v10}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v10}, Lchat/ola/vn/message/f;->k()S

    move-result v13

    invoke-virtual {v11, v12, v13}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v11

    if-eqz v11, :cond_1

    invoke-virtual {v10}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v12

    invoke-virtual {v11, v12, v13}, Lchat/ola/vn/message/f;->b(J)V

    :cond_1
    invoke-virtual {v10}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v12

    invoke-virtual {v0, v12, v13}, Ljava/util/Calendar;->setTimeInMillis(J)V

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v12

    invoke-virtual {v0, v3}, Ljava/util/Calendar;->get(I)I

    move-result v13

    if-ne v2, v12, :cond_0

    if-ne v4, v13, :cond_0

    if-nez v7, :cond_2

    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    :cond_2
    if-nez v11, :cond_3

    goto :goto_1

    :cond_3
    move-object v10, v11

    :goto_1
    invoke-interface {v7, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-static {v8}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_4

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "@"

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v10}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    goto :goto_0

    :cond_4
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v8, ", @"

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v10}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    goto :goto_0

    :cond_5
    if-eqz v7, :cond_d

    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_d

    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    const v1, 0x7f0f00dd

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/c;->b(I)Lchat/ola/vn/entry/e;

    move-result-object v0

    if-nez v0, :cond_6

    new-instance v0, Lchat/ola/vn/o/b;

    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {v0, v1}, Lchat/ola/vn/o/b;-><init>(I)V

    :cond_6
    const v1, 0x5f5e100

    mul-int/lit16 v9, v6, 0x2710

    mul-int/lit8 v10, v4, 0x64

    add-int/2addr v9, v10

    add-int/2addr v9, v2

    add-int/2addr v9, v1

    invoke-virtual {v0, v9}, Lchat/ola/vn/entry/e;->c(I)V

    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v1

    int-to-long v9, v1

    invoke-static {v9, v10}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/e;->c(Ljava/lang/String;)V

    invoke-virtual {v0, v8}, Lchat/ola/vn/entry/e;->d(Ljava/lang/String;)V

    invoke-virtual {v0, v3}, Lchat/ola/vn/entry/e;->b(I)V

    sget-object v1, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v1, v0}, Lchat/ola/vn/r/a/c;->a(Lchat/ola/vn/entry/e;)V

    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/c;->a()V

    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/c;->g()V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, v7}, Lchat/ola/vn/message/g;->c(Ljava/util/List;)V

    invoke-static {}, Lchat/ola/vn/h/b;->c()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_c

    const-string v2, ";"

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_d

    array-length v3, v2

    if-lez v3, :cond_d

    const/4 v3, 0x0

    aget-object v4, v2, v3

    invoke-static {v4, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_b

    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    move-object v4, v0

    const/4 v0, 0x0

    :cond_7
    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_a

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lchat/ola/vn/message/f;

    const/4 v7, 0x1

    :goto_3
    array-length v8, v2

    if-ge v7, v8, :cond_9

    aget-object v8, v2, v7

    invoke-virtual {v6}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_8

    const/4 v7, 0x1

    goto :goto_4

    :cond_8
    add-int/lit8 v7, v7, 0x1

    goto :goto_3

    :cond_9
    const/4 v7, 0x0

    :goto_4
    if-nez v7, :cond_7

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ";"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v6}, Lchat/ola/vn/util/c/b;->a(Lchat/ola/vn/message/f;)V

    move-object v4, v0

    const/4 v0, 0x1

    goto :goto_2

    :cond_a
    if-eqz v0, :cond_d

    invoke-static {v4}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;)V

    return-void

    :cond_b
    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_5
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_d

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/message/f;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ";"

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2}, Lchat/ola/vn/util/c/b;->a(Lchat/ola/vn/message/f;)V

    invoke-static {v1}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;)V

    goto :goto_5

    :cond_c
    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_6
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_d

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/message/f;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ";"

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2}, Lchat/ola/vn/util/c/b;->a(Lchat/ola/vn/message/f;)V

    invoke-static {v1}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_6

    :catch_0
    :cond_d
    return-void
.end method
