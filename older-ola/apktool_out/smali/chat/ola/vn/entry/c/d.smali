.class public Lchat/ola/vn/entry/c/d;
.super Lchat/ola/vn/entry/c/e;


# instance fields
.field private a:Lchat/ola/vn/entity/t;

.field private b:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lchat/ola/vn/entity/t;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    iput-object p2, p0, Lchat/ola/vn/entry/c/d;->b:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/4 v0, 0x5

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/t;->a(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/t;->b(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 10

    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v2}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v2

    aget-object v3, p1, v1

    check-cast v3, Lchat/ola/vn/entity/ad;

    invoke-virtual {v3}, Lchat/ola/vn/entity/ad;->m()S

    move-result v4

    const/4 v5, 0x1

    packed-switch v4, :pswitch_data_0

    iget-object p1, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    goto/16 :goto_2

    :pswitch_0
    array-length v4, p1

    if-le v4, v5, :cond_6

    aget-object v4, p1, v5
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v6, 0x2

    if-eqz v4, :cond_4

    :try_start_1
    aget-object v4, p1, v5

    check-cast v4, Ljava/util/List;

    invoke-static {v4}, Lchat/ola/vn/entity/t;->c(Ljava/util/List;)Ljava/util/List;

    move-result-object v4

    if-eqz v4, :cond_4

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v7

    if-lez v7, :cond_4

    sget-short v7, Lchat/ola/vn/h;->H:S

    if-gtz v7, :cond_2

    invoke-virtual {v3}, Lchat/ola/vn/entity/ad;->m()S

    move-result v7

    if-ne v7, v6, :cond_0

    sget-boolean v7, Lchat/ola/vn/util/a;->b:Z

    if-nez v7, :cond_1

    :cond_0
    sget-boolean v7, Lchat/ola/vn/util/a;->a:Z

    if-eqz v7, :cond_2

    :cond_1
    new-instance v7, Lchat/ola/vn/entity/t;

    const-string v8, ""

    invoke-direct {v7, v8}, Lchat/ola/vn/entity/t;-><init>(Ljava/lang/String;)V

    new-instance v8, Ljava/util/Random;

    invoke-direct {v8}, Ljava/util/Random;-><init>()V

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v9

    invoke-virtual {v8, v9}, Ljava/util/Random;->nextInt(I)I

    move-result v8

    invoke-interface {v4, v8, v7}, Ljava/util/List;->add(ILjava/lang/Object;)V

    :cond_2
    iget-object v7, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v7, v3}, Lchat/ola/vn/entity/t;->a(Lchat/ola/vn/entity/ad;)V

    iget-object v3, p0, Lchat/ola/vn/entry/c/d;->b:Ljava/lang/String;

    if-eqz v3, :cond_3

    iget-object v3, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v4}, Lchat/ola/vn/entity/t;->b(Ljava/util/List;)V

    goto :goto_0

    :cond_3
    iget-object v2, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    invoke-virtual {v2, v7, v8}, Lchat/ola/vn/entity/t;->a(J)V

    iget-object v2, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v4}, Lchat/ola/vn/entity/t;->a(Ljava/util/List;)V

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v5}, Lchat/ola/vn/entity/t;->a(Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    :try_start_2
    iget-object v2, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/t;->a(Z)V

    :cond_4
    :goto_1
    aget-object v2, p1, v6

    if-eqz v2, :cond_5

    iget-object v2, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    aget-object p1, p1, v6

    check-cast p1, Ljava/lang/String;

    invoke-virtual {v2, p1}, Lchat/ola/vn/entity/t;->a(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v5}, Lchat/ola/vn/entity/t;->b(Z)V

    return-void

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/t;->a(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/t;->b(Z)V

    return-void

    :goto_2
    invoke-virtual {p1, v3}, Lchat/ola/vn/entity/t;->a(Lchat/ola/vn/entity/ad;)V

    iget-object p1, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v5}, Lchat/ola/vn/entity/t;->a(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/t;->a(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/t;->b(Z)V

    iget-object p1, p0, Lchat/ola/vn/entry/c/d;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/t;->b(Z)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    :cond_6
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method
