.class public Lchat/ola/vn/q/b;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/activity/OlaCropImageActivity$a;


# static fields
.field private static a:Lchat/ola/vn/q/b;


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a(Lchat/ola/vn/entry/b;I)Lchat/ola/vn/entity/i;
    .locals 0

    :try_start_0
    iget-object p1, p1, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_0

    new-instance p2, Lchat/ola/vn/entity/i;

    invoke-direct {p2}, Lchat/ola/vn/entity/i;-><init>()V

    invoke-virtual {p2, p1}, Lchat/ola/vn/entity/i;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public static a()Lchat/ola/vn/q/b;
    .locals 1

    sget-object v0, Lchat/ola/vn/q/b;->a:Lchat/ola/vn/q/b;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/q/b;

    invoke-direct {v0}, Lchat/ola/vn/q/b;-><init>()V

    sput-object v0, Lchat/ola/vn/q/b;->a:Lchat/ola/vn/q/b;

    :cond_0
    sget-object v0, Lchat/ola/vn/q/b;->a:Lchat/ola/vn/q/b;

    return-object v0
.end method

.method private a(Landroid/content/Context;Landroid/view/View;I)V
    .locals 0

    :try_start_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/q/b;->a(Lchat/ola/vn/entry/b;I)Lchat/ola/vn/entity/i;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Lchat/ola/vn/entity/i;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V
    .locals 0

    invoke-static {p1, p2, p3, p4}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    :try_start_0
    invoke-virtual {p4}, Lchat/ola/vn/entry/b;->f()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result p2

    const/4 p3, 0x1

    if-ne p2, p3, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p4, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p3}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object p3

    invoke-static {p2, p3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_0

    new-instance p2, Lchat/ola/vn/d/b;

    invoke-direct {p2, p4}, Lchat/ola/vn/d/b;-><init>(Lchat/ola/vn/entry/b;)V

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p2}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result p2

    invoke-virtual {p3, p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->n(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private a(Landroid/content/Context;Landroid/view/View;Lchat/ola/vn/entity/d;)V
    .locals 3

    :try_start_0
    iget-object v0, p3, Lchat/ola/vn/entity/d;->a:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->f()I

    move-result v0

    iget-object v1, p3, Lchat/ola/vn/entity/d;->a:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->i()S

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    iget-object p2, p3, Lchat/ola/vn/entity/d;->a:Lchat/ola/vn/entity/g;

    const/4 v1, 0x0

    invoke-virtual {p2, v1}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object p2, p3, Lchat/ola/vn/entity/d;->a:Lchat/ola/vn/entity/g;

    sub-int/2addr v0, v2

    invoke-virtual {p2, v0}, Lchat/ola/vn/entity/g;->a(I)V

    goto :goto_0

    :cond_0
    iget-object v1, p3, Lchat/ola/vn/entity/d;->a:Lchat/ola/vn/entity/g;

    invoke-virtual {v1, v2}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object v1, p3, Lchat/ola/vn/entity/d;->a:Lchat/ola/vn/entity/g;

    add-int/2addr v0, v2

    invoke-virtual {v1, v0}, Lchat/ola/vn/entity/g;->a(I)V

    const v0, 0x7f010057

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    const-wide/16 v1, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-virtual {p2, v0}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    :goto_0
    invoke-static {p1, p3}, Lchat/ola/vn/entity/d;->a(Landroid/content/Context;Lchat/ola/vn/entity/d;)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/c;->j()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Landroid/content/Context;Landroid/view/View;Lchat/ola/vn/entry/b;)V
    .locals 9

    invoke-virtual {p3}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    if-nez v0, :cond_4

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/4 v3, 0x1

    if-eqz v0, :cond_1

    iget-object v4, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v4

    iget-object v6, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v6}, Lchat/ola/vn/entity/g;->i()S

    move-result v6

    if-eq v6, v2, :cond_0

    const/4 v6, 0x1

    goto :goto_0

    :cond_0
    const/4 v6, 0x0

    :goto_0
    invoke-virtual {v0, v4, v5, v6}, Lchat/ola/vn/network/OlaNetworkService;->a(JZ)V

    :cond_1
    iget-object v0, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->D()I

    move-result v0

    iget-object v4, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->i()S

    move-result v4

    const-wide/16 v5, 0x64

    const v7, 0x7f090548

    if-ne v4, v2, :cond_2

    iget-object v2, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object p3, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    sub-int/2addr v0, v3

    invoke-virtual {p3, v0}, Lchat/ola/vn/entity/g;->c(I)V

    :try_start_0
    invoke-virtual {p2, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    const p3, 0x7f010058

    invoke-static {p1, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    :goto_1
    invoke-virtual {p1, v5, v6}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-virtual {p2, p1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :cond_2
    iget-object v4, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->i()S

    move-result v4

    if-ne v4, v3, :cond_3

    iget-object v4, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->f()I

    move-result v4

    iget-object v8, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v8, v1}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object v1, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    sub-int/2addr v4, v3

    invoke-virtual {v1, v4}, Lchat/ola/vn/entity/g;->a(I)V

    :cond_3
    iget-object v1, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1, v2}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object p3, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    add-int/2addr v0, v3

    invoke-virtual {p3, v0}, Lchat/ola/vn/entity/g;->c(I)V

    :try_start_1
    invoke-virtual {p2, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    const p3, 0x7f010057

    invoke-static {p1, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    :goto_2
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/c;->j()V

    :cond_4
    return-void
.end method

.method private a(Landroid/content/Context;Landroid/view/View;Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Landroid/view/View;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Lcom/mg/ola/common/c/b;

    invoke-direct {v0, p1}, Lcom/mg/ola/common/c/b;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/c/b;->a(Z)V

    invoke-interface {p3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result v2

    packed-switch v2, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    new-instance v2, Lcom/mg/ola/common/c/a;

    const v3, 0x7f080717

    const-string v4, ""

    invoke-direct {v2, p1, v3, v4}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    goto :goto_1

    :pswitch_1
    new-instance v2, Lcom/mg/ola/common/c/a;

    const v3, 0x7f08071a

    const-string v4, ""

    invoke-direct {v2, p1, v3, v4}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    goto :goto_1

    :pswitch_2
    new-instance v2, Lcom/mg/ola/common/c/a;

    const v3, 0x7f080714

    const-string v4, ""

    invoke-direct {v2, p1, v3, v4}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    :goto_1
    invoke-virtual {v0, v2}, Lcom/mg/ola/common/c/b;->a(Lcom/mg/ola/common/c/a;)V

    goto :goto_0

    :cond_0
    new-instance v1, Lchat/ola/vn/q/b$6;

    invoke-direct {v1, p0, p3, p1}, Lchat/ola/vn/q/b$6;-><init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/c/b;->a(Lcom/mg/ola/common/c/c$a;)V

    invoke-virtual {v0, p2}, Lcom/mg/ola/common/c/b;->a(Landroid/view/View;)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private a(Landroid/content/Context;Lchat/ola/vn/entry/b;J)V
    .locals 0

    iget-object p2, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide p2

    invoke-static {p1, p2, p3}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(Landroid/content/Context;J)V

    return-void
.end method

.method private a(Landroid/content/Context;Lchat/ola/vn/entry/b;Ljava/lang/String;)V
    .locals 10

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_0

    return-void

    :cond_0
    iget-object v5, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const v1, 0x7f0f056b

    const v3, 0x7f0f04ae

    const v6, 0x7f0f0491

    if-eqz v0, :cond_1

    invoke-virtual {p1, v6}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    const v0, 0x7f0f0465

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v6}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f0434

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :goto_1
    new-instance v8, Lchat/ola/vn/i/m;

    invoke-direct {v8, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v8, v2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v9, Lchat/ola/vn/q/b$11;

    move-object v0, v9

    move-object v1, p0

    move-object v3, p1

    move-object v6, p2

    move-object v7, p3

    invoke-direct/range {v0 .. v7}, Lchat/ola/vn/q/b$11;-><init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/g;Lchat/ola/vn/entry/b;Ljava/lang/String;)V

    invoke-virtual {v8, v9}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v8}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private a(Landroid/content/Context;Lchat/ola/vn/message/f;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0492

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0493

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f043c

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f042f

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    if-eqz p2, :cond_0

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object p2

    invoke-virtual {v1, p2}, Lchat/ola/vn/i/m;->setTitle(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    invoke-virtual {v1, p3}, Lchat/ola/vn/i/m;->a(Ljava/lang/String;)V

    :goto_0
    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance p2, Lchat/ola/vn/q/b$7;

    invoke-direct {p2, p0, v0, p1, p3}, Lchat/ola/vn/q/b$7;-><init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 8

    :try_start_0
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v1, 0x0

    invoke-virtual {v0, p2, v1}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v5

    if-nez v5, :cond_0

    const v0, 0x7f0f0550

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    const v0, 0x7f0f0465

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f06a7

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f056b

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v6, Lchat/ola/vn/i/m;

    invoke-direct {v6, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    if-eqz v5, :cond_1

    invoke-virtual {v5}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v6, v0}, Lchat/ola/vn/i/m;->setTitle(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    invoke-virtual {v6, p2}, Lchat/ola/vn/i/m;->a(Ljava/lang/String;)V

    :goto_0
    invoke-virtual {v6, v2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v7, Lchat/ola/vn/q/b$1;

    move-object v0, v7

    move-object v1, p0

    move-object v3, p1

    move-object v4, p2

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/q/b$1;-><init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/message/f;)V

    invoke-virtual {v6, v7}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v6}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/q/b;Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->e(Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/q/b;Landroid/content/Context;Lchat/ola/vn/entry/b;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/q/b;->c(Landroid/content/Context;Lchat/ola/vn/entry/b;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/q/b;Landroid/content/Context;Lchat/ola/vn/message/f;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Lchat/ola/vn/message/f;Ljava/lang/String;)V

    return-void
.end method

.method private b(Landroid/content/Context;Landroid/view/View;Lchat/ola/vn/entry/b;)V
    .locals 8

    invoke-virtual {p3}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    if-nez v0, :cond_4

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v1

    iget-object v3, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->i()S

    move-result v3

    const/4 v4, 0x0

    const/4 v5, 0x1

    if-eq v3, v5, :cond_0

    const/4 v3, 0x1

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    :goto_0
    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->b(JZ)Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->f()I

    move-result v0

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    iget-object v2, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->i()S

    move-result v2

    const-wide/16 v6, 0x64

    const v3, 0x7f09054b

    if-ne v2, v5, :cond_2

    iget-object v2, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2, v4}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object p3, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    sub-int/2addr v0, v5

    invoke-virtual {p3, v0}, Lchat/ola/vn/entity/g;->a(I)V

    :try_start_0
    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    const p3, 0x7f010058

    invoke-static {p1, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    invoke-virtual {p1, v6, v7}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-virtual {p2, p1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_2
    iget-object v2, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->i()S

    move-result v2

    const/4 v4, 0x2

    if-ne v2, v4, :cond_3

    iget-object v2, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->D()I

    move-result v2

    iget-object v4, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    sub-int/2addr v2, v5

    invoke-virtual {v4, v2}, Lchat/ola/vn/entity/g;->c(I)V

    :cond_3
    iget-object v2, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2, v5}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object p3, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    add-int/2addr v0, v5

    invoke-virtual {p3, v0}, Lchat/ola/vn/entity/g;->a(I)V

    :try_start_1
    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    const p3, 0x7f010057

    invoke-static {p1, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    invoke-virtual {p1, v6, v7}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-virtual {p2, p1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    invoke-virtual {v1}, Lchat/ola/vn/c;->z()Landroid/widget/FrameLayout;

    move-result-object p1

    invoke-virtual {v1, p2, p1}, Lchat/ola/vn/c;->b(Landroid/view/View;Landroid/widget/FrameLayout;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :goto_1
    invoke-virtual {v1}, Lchat/ola/vn/c;->j()V

    :cond_4
    return-void
.end method

.method private b(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 4

    iget-object v0, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->k()S

    move-result v0

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    iget-object p2, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->b(Landroid/content/Context;J)V

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/e;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->c()I

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    :cond_1
    iget-object v0, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/i;->a(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    move-object v0, v1

    :cond_3
    :goto_0
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    const/4 v0, 0x0

    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object p2, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v2

    invoke-static {p1, v1, v0, v2, v3}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)V

    return-void
.end method

.method private b(Landroid/content/Context;Lchat/ola/vn/entry/b;Ljava/lang/String;)V
    .locals 10

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_0

    return-void

    :cond_0
    iget-object v5, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const v1, 0x7f0f056b

    const v3, 0x7f0f04ae

    const v6, 0x7f0f0491

    if-eqz v0, :cond_1

    invoke-virtual {p1, v6}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    const v0, 0x7f0f0465

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v6}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f0434

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :goto_1
    new-instance v8, Lchat/ola/vn/i/m;

    invoke-direct {v8, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v8, v2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v9, Lchat/ola/vn/q/b$12;

    move-object v0, v9

    move-object v1, p0

    move-object v3, p1

    move-object v6, p2

    move-object v7, p3

    invoke-direct/range {v0 .. v7}, Lchat/ola/vn/q/b$12;-><init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/g;Lchat/ola/vn/entry/b;Ljava/lang/String;)V

    invoke-virtual {v8, v9}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v8}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/q/b;Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->h(Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/q/b;Landroid/content/Context;Lchat/ola/vn/entry/b;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/q/b;->d(Landroid/content/Context;Lchat/ola/vn/entry/b;Ljava/lang/String;)V

    return-void
.end method

.method private c(Landroid/content/Context;Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    iget-object p2, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    const/4 v0, 0x0

    invoke-interface {p2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/entity/i;

    invoke-direct {v0}, Lchat/ola/vn/entity/i;-><init>()V

    invoke-virtual {v0, p2}, Lchat/ola/vn/entity/i;->a(Ljava/lang/String;)V

    invoke-static {p1, v0}, Lchat/ola/vn/i/i;->c(Landroid/content/Context;Lchat/ola/vn/entity/i;)V

    return-void

    :cond_0
    iget-object v0, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method private c(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-direct {p0, p1, p2, v1}, Lchat/ola/vn/q/b;->b(Landroid/content/Context;Lchat/ola/vn/entry/b;Ljava/lang/String;)V

    return-void

    :cond_1
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    :goto_0
    invoke-direct {p0, p1, p2, v1}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Lchat/ola/vn/entry/b;Ljava/lang/String;)V

    return-void

    :cond_2
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    goto :goto_0

    :cond_3
    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->d(Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    return-void

    :cond_4
    :goto_1
    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->f(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private c(Landroid/content/Context;Lchat/ola/vn/entry/b;Ljava/lang/String;)V
    .locals 8

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_0

    return-void

    :cond_0
    iget-object v6, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    const p2, 0x7f0f0218

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object v4, v0, v1

    invoke-virtual {p1, p2, v0}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v2, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p2, 0x7f0f0493

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v2, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p2, Lchat/ola/vn/i/m;

    invoke-direct {p2, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {p2, v2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v7, Lchat/ola/vn/q/b$13;

    move-object v0, v7

    move-object v1, p0

    move-object v3, p1

    move-object v5, p3

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/q/b$13;-><init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/g;)V

    invoke-virtual {p2, v7}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {p2}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/q/b;Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->g(Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    return-void
.end method

.method private d(Landroid/content/Context;Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    iget-object p2, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    const/4 v0, 0x0

    invoke-interface {p2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/entity/i;

    invoke-direct {v0}, Lchat/ola/vn/entity/i;-><init>()V

    invoke-virtual {v0, p2}, Lchat/ola/vn/entity/i;->a(Ljava/lang/String;)V

    invoke-static {p1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Lchat/ola/vn/entity/i;)V

    return-void

    :cond_0
    iget-object v0, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method private d(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 9

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_0

    return-void

    :cond_0
    iget-object v5, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const v1, 0x7f0f056b

    const v3, 0x7f0f0493

    const v6, 0x7f0f0491

    if-eqz v0, :cond_1

    :goto_0
    invoke-virtual {p1, v6}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    const v0, 0x7f0f0465

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :goto_1
    new-instance v7, Lchat/ola/vn/i/m;

    invoke-direct {v7, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v7, v2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v8, Lchat/ola/vn/q/b$9;

    move-object v0, v8

    move-object v1, p0

    move-object v3, p1

    move-object v6, p2

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/q/b$9;-><init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/g;Lchat/ola/vn/entry/b;)V

    invoke-virtual {v7, v8}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v7}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private d(Landroid/content/Context;Lchat/ola/vn/entry/b;Ljava/lang/String;)V
    .locals 8

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v6

    if-nez v6, :cond_0

    return-void

    :cond_0
    iget-object v4, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    const p2, 0x7f0f0441

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v2, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p2, 0x7f0f05b4

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v2, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p2, 0x7f0f04bf

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v2, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p2, 0x7f0f0218

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object v6, v0, v1

    invoke-virtual {p1, p2, v0}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v2, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p2, 0x7f0f0493

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v2, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p2, Lchat/ola/vn/i/m;

    invoke-direct {p2, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {p2, v2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v7, Lchat/ola/vn/q/b$14;

    move-object v0, v7

    move-object v1, p0

    move-object v3, p1

    move-object v5, p3

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/q/b$14;-><init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entity/g;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p2, v7}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {p2}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private e(Landroid/content/Context;Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    iget-object v0, p2, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-byte v0, p2, Lchat/ola/vn/entry/b;->l:B

    packed-switch v0, :pswitch_data_0

    iget-object p2, p2, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    goto :goto_0

    :pswitch_0
    new-instance v0, Lchat/ola/vn/entity/i;

    invoke-direct {v0}, Lchat/ola/vn/entity/i;-><init>()V

    iget-object p2, p2, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-virtual {v0, p2}, Lchat/ola/vn/entity/i;->a(Ljava/lang/String;)V

    invoke-static {p1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Lchat/ola/vn/entity/i;)V

    return-void

    :pswitch_1
    iget-object v0, p2, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    iget-object p2, p2, Lchat/ola/vn/entry/b;->q:Ljava/lang/String;

    invoke-static {p1, v0, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :goto_0
    invoke-static {p1, p2}, Lchat/ola/vn/i/i;->e(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private e(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 3

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0628

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f00fa

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/q/b$10;

    invoke-direct {v2, p0, v0, p1, p2}, Lchat/ola/vn/q/b$10;-><init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private f(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 9

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_0

    return-void

    :cond_0
    iget-object v6, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const v1, 0x7f0f04ae

    const v3, 0x7f0f0493

    const v5, 0x7f0f0491

    if-nez v0, :cond_2

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const v7, 0x7f0f056b

    if-eqz v0, :cond_1

    :goto_0
    invoke-virtual {p1, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v7}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_1
    const v0, 0x7f0f0465

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v7, 0x1

    if-ne v0, v7, :cond_3

    :goto_2
    invoke-virtual {p1, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_3
    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v7, 0x2

    if-ne v0, v7, :cond_4

    goto :goto_2

    :cond_4
    :goto_3
    new-instance v7, Lchat/ola/vn/i/m;

    invoke-direct {v7, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v7, v2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v8, Lchat/ola/vn/q/b$2;

    move-object v0, v8

    move-object v1, p0

    move-object v3, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/q/b$2;-><init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entry/b;Lchat/ola/vn/entity/g;)V

    invoke-virtual {v7, v8}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v7}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private g(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 9

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_0

    return-void

    :cond_0
    iget-object v6, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    if-nez v0, :cond_2

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const v1, 0x7f0f00fa

    const v3, 0x7f0f05b3

    if-eqz v0, :cond_1

    :goto_0
    invoke-virtual {p1, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_1
    const v0, 0x7f0f0628

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v1, 0x1

    const v3, 0x7f0f04ae

    const v5, 0x7f0f0493

    const v7, 0x7f0f0491

    if-ne v0, v1, :cond_3

    :goto_2
    invoke-virtual {p1, v7}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_3
    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_4

    goto :goto_2

    :cond_4
    :goto_3
    new-instance v7, Lchat/ola/vn/i/m;

    invoke-direct {v7, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v7, v2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v8, Lchat/ola/vn/q/b$3;

    move-object v0, v8

    move-object v1, p0

    move-object v3, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/q/b$3;-><init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entry/b;Lchat/ola/vn/entity/g;)V

    invoke-virtual {v7, v8}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v7}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private h(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 6

    new-instance v5, Lchat/ola/vn/q/b$4;

    invoke-direct {v5, p0, p1, p2}, Lchat/ola/vn/q/b$4;-><init>(Lchat/ola/vn/q/b;Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    const v1, 0x7f0f00a2

    const v2, 0x7f0f0168

    const v3, 0x7f0f0628

    const v4, 0x7f0f0480

    move-object v0, p1

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void
.end method


# virtual methods
.method public D()V
    .locals 1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c;->j()V

    return-void
.end method

.method public E()V
    .locals 1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c;->j()V

    return-void
.end method

.method public F()V
    .locals 0

    return-void
.end method

.method public G()V
    .locals 0

    return-void
.end method

.method protected a(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 11

    new-instance v0, Ljava/lang/StringBuilder;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "@"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const v3, 0x7f0f0161

    invoke-virtual {p1, v3, v2}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x0

    :try_start_0
    iget-object v3, p2, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    if-nez v2, :cond_0

    move-object v2, v5

    goto :goto_0

    :cond_0
    const-string v6, "#\u001b"

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "# "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_1
    :try_start_1
    iget-object v3, p2, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    if-nez v2, :cond_2

    move-object v2, v5

    goto :goto_1

    :cond_2
    const-string v6, "#\u001b"

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "# "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    :cond_3
    :try_start_2
    iget-object v3, p2, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    if-nez v2, :cond_4

    move-object v2, v5

    goto :goto_2

    :cond_4
    const-string v6, "#\u001b"

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "# "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_2

    :catch_2
    :cond_5
    iget-object v3, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object v3

    const-string v5, ""

    invoke-static {v3, v5}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;)Ljava/lang/StringBuilder;

    iget-object p2, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->B()Lchat/ola/vn/entity/w;

    move-result-object p2

    if-eqz p2, :cond_7

    invoke-virtual {p2}, Lchat/ola/vn/entity/w;->c()I

    move-result v0

    int-to-short v4, v0

    if-nez v2, :cond_6

    invoke-virtual {p2}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object v2

    :cond_6
    move-object v7, v2

    move v8, v4

    goto :goto_3

    :cond_7
    move-object v7, v2

    const/4 v8, 0x0

    :goto_3
    sget-object v5, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v5, :cond_8

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-virtual/range {v5 .. v10}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V

    :cond_8
    const p2, 0x7f0f0629

    const-wide/16 v0, 0xbb8

    new-instance v2, Lchat/ola/vn/q/b$5;

    invoke-direct {v2, p0, p1}, Lchat/ola/vn/q/b$5;-><init>(Lchat/ola/vn/q/b;Landroid/content/Context;)V

    invoke-static {p1, p2, v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IJLjava/lang/Runnable;)Lchat/ola/vn/i/c;

    return-void
.end method

.method public a(Landroid/content/Context;Landroid/view/View;)Z
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    if-nez v1, :cond_0

    return v0

    :cond_0
    invoke-virtual {p2}, Landroid/view/View;->getId()I

    move-result v1

    const/4 v2, 0x1

    sparse-switch v1, :sswitch_data_0

    return v0

    :sswitch_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entry/b;

    iget-object v3, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->i()S

    move-result v3

    if-eq v3, v2, :cond_2

    invoke-direct {p0, p1, p2, v1}, Lchat/ola/vn/q/b;->b(Landroid/content/Context;Landroid/view/View;Lchat/ola/vn/entry/b;)V

    invoke-virtual {v1}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, p1}, Lchat/ola/vn/network/OlaNetworkService;->i(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/c;->z()Landroid/widget/FrameLayout;

    move-result-object v1

    invoke-virtual {p1, p2, v1}, Lchat/ola/vn/c;->a(Landroid/view/View;Landroid/widget/FrameLayout;)V

    :cond_1
    return v2

    :sswitch_1
    const/4 v1, 0x4

    invoke-direct {p0, p1, p2, v1}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;I)V

    return v2

    :sswitch_2
    const/4 v1, 0x3

    invoke-direct {p0, p1, p2, v1}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;I)V

    return v2

    :sswitch_3
    const/4 v1, 0x2

    invoke-direct {p0, p1, p2, v1}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;I)V

    return v2

    :sswitch_4
    invoke-direct {p0, p1, p2, v2}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;I)V

    return v2

    :sswitch_5
    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;I)V

    return v2

    :sswitch_6
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    return v2

    :sswitch_7
    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->e(Landroid/content/Context;Landroid/view/View;)V

    return v2

    :sswitch_8
    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->d(Landroid/content/Context;Landroid/view/View;)V

    return v2

    :sswitch_9
    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->c(Landroid/content/Context;Landroid/view/View;)V

    return v2

    :cond_2
    :sswitch_a
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    if-nez v1, :cond_3

    return v0

    :cond_3
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entry/b;

    invoke-virtual {v1}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_5

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-static {p1, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return v2

    :cond_4
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->i(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    if-eqz p1, :cond_5

    invoke-virtual {p1}, Lchat/ola/vn/c;->z()Landroid/widget/FrameLayout;

    move-result-object v1

    invoke-virtual {p1, p2, v1}, Lchat/ola/vn/c;->a(Landroid/view/View;Landroid/widget/FrameLayout;)V

    :cond_5
    return v2

    :sswitch_b
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return v2

    :sswitch_c
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->h(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v2

    :catch_0
    return v0

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f0900f5 -> :sswitch_c
        0x7f0901b9 -> :sswitch_b
        0x7f09028e -> :sswitch_a
        0x7f090292 -> :sswitch_9
        0x7f090293 -> :sswitch_8
        0x7f090295 -> :sswitch_7
        0x7f090307 -> :sswitch_7
        0x7f09033a -> :sswitch_6
        0x7f090348 -> :sswitch_5
        0x7f090349 -> :sswitch_4
        0x7f09034a -> :sswitch_3
        0x7f09034b -> :sswitch_2
        0x7f09034c -> :sswitch_1
        0x7f0903e7 -> :sswitch_b
        0x7f0904a7 -> :sswitch_b
        0x7f09054e -> :sswitch_0
    .end sparse-switch
.end method

.method public b(Landroid/content/Context;Landroid/view/View;)V
    .locals 8

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-virtual {p2}, Landroid/view/View;->getId()I

    move-result v2

    const/4 v3, 0x0

    const/4 v4, 0x1

    const/4 v5, 0x0

    sparse-switch v2, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-static {}, Lchat/ola/vn/c/x;->i()Ljava/lang/String;

    move-result-object p2

    const-string v0, "vip_account_introduction"

    const-string v1, "vi"

    invoke-static {p2, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "-vi.html"

    :goto_0
    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    goto :goto_1

    :cond_0
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "-en.html"

    goto :goto_0

    :goto_1
    const v0, 0x7f0f0391

    invoke-static {p1, v0, p2}, Lchat/ola/vn/i/o;->a(Landroid/content/Context;ILjava/lang/String;)Lchat/ola/vn/i/o;

    move-result-object p2

    const v0, 0x7f0f0444

    new-instance v1, Lchat/ola/vn/q/b$8;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/q/b$8;-><init>(Lchat/ola/vn/q/b;Landroid/content/Context;)V

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/i/o;->a(ILjava/lang/Runnable;)V

    return-void

    :sswitch_1
    invoke-static {p1, v4}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->a(Landroid/content/Context;Z)V

    return-void

    :sswitch_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    iget-object v0, p2, Lchat/ola/vn/entry/b;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_21

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p2, Lchat/ola/vn/entry/b;->f:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_1
    iget-object p2, p2, Lchat/ola/vn/entry/b;->f:Ljava/lang/String;

    invoke-static {p1, p2}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_3
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "note/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/m/j;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_4
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_2

    return-void

    :cond_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/q/b;->b(Landroid/content/Context;Landroid/view/View;Lchat/ola/vn/entry/b;)V

    return-void

    :sswitch_5
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_3

    return-void

    :cond_3
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;Lchat/ola/vn/entry/b;)V

    return-void

    :sswitch_6
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entity/o;

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "_byte_data"

    invoke-virtual {p2}, Lchat/ola/vn/entity/o;->d()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, v1, p2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance p2, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    invoke-direct {p2, p1, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x20000

    invoke-virtual {p2, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    invoke-virtual {p2, v0}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    invoke-virtual {p1, p2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    check-cast p1, Lchat/ola/vn/c;

    const p2, 0x7f010038

    const v0, 0x7f010039

    invoke-virtual {p1, p2, v0}, Lchat/ola/vn/c;->overridePendingTransition(II)V

    return-void

    :goto_2
    :sswitch_7
    invoke-static {p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;)V

    return-void

    :sswitch_8
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    const/4 v1, 0x4

    :goto_3
    invoke-direct {p0, p1, p2, v1, v0}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_9
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    const/4 v1, 0x3

    goto :goto_3

    :sswitch_a
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    const/4 v1, 0x2

    goto :goto_3

    :sswitch_b
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p1, p2, v4, v0}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_c
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p1, p2, v5, v0}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_d
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_21

    iget-byte v1, v0, Lchat/ola/vn/entry/b;->l:B

    packed-switch v1, :pswitch_data_0

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    goto :goto_6

    :pswitch_0
    iget-object p2, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    :goto_4
    invoke-static {p1, p2}, Lchat/ola/vn/util/b;->h(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_1
    iget-object p2, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    :goto_5
    invoke-static {p1, p2}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :goto_6
    invoke-static {p1, v0, p2}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;Landroid/view/View;)V

    return-void

    :sswitch_e
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_4

    return-void

    :cond_4
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    if-eqz v1, :cond_21

    iget-object v1, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_21

    iget-object v1, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ne v1, v4, :cond_5

    iget-object p2, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {p2, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    goto :goto_4

    :cond_5
    iget-object v0, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    :goto_7
    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;Ljava/util/List;)V

    return-void

    :sswitch_f
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_6

    return-void

    :cond_6
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    if-eqz v1, :cond_21

    iget-object v1, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_21

    iget-object v1, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ne v1, v4, :cond_7

    iget-object p2, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {p2, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    :goto_8
    invoke-static {p1, p2}, Lchat/ola/vn/util/b;->f(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_7
    iget-object v0, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    goto :goto_7

    :sswitch_10
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_8

    return-void

    :cond_8
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    :catch_0
    :goto_9
    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object p2

    :goto_a
    invoke-static {p1, p2}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_11
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entity/d;

    invoke-static {p1, p2}, Lchat/ola/vn/entity/d;->a(Landroid/content/Context;Lchat/ola/vn/entity/d;)V

    return-void

    :sswitch_12
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    goto :goto_a

    :sswitch_13
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :cond_9

    return-void

    :cond_9
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p1, p2, v0, v1}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Lchat/ola/vn/entry/b;J)V

    return-void

    :sswitch_14
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    iget-object v0, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->f()I

    move-result v0

    iget-object p2, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v1

    invoke-static {p1, v0, v1, v2}, Lchat/ola/vn/me/OlaMeLikerListActivity;->a(Landroid/content/Context;IJ)V

    return-void

    :sswitch_15
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_a

    return-void

    :cond_a
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    iget-object p2, p2, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p2, p2, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-virtual {p2}, Lchat/ola/vn/entity/d;->b()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_21

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const v1, 0x7f0f062b

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nrss://"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V

    const p2, 0x7f0f00a2

    const v0, 0x7f0f035c

    invoke-static {p1, p2, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :sswitch_16
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_b

    return-void

    :cond_b
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->b(Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    return-void

    :sswitch_17
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_c

    return-void

    :cond_c
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/q/b;->c(Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    return-void

    :sswitch_18
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    sget-object p2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p2, p1}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entry/b;)Z

    :cond_d
    :goto_b
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/c;->j()V

    return-void

    :sswitch_19
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    iget-object v0, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->u()Ljava/lang/String;

    move-result-object v0

    iget-object p2, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->f()I

    move-result p2

    invoke-static {p1, v0, p2}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->a(Landroid/content/Context;Ljava/lang/String;I)V

    return-void

    :sswitch_1a
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    iget-object v0, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->q()Ljava/lang/String;

    move-result-object v0

    const-string v1, "update"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_e

    sput-object v3, Lchat/ola/vn/h;->L:Ljava/lang/String;

    sput-object v3, Lchat/ola/vn/h;->M:Ljava/lang/String;

    sput-object v3, Lchat/ola/vn/h;->N:Ljava/lang/String;

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1, p2}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entry/b;)Z

    goto :goto_b

    :cond_e
    sget-short v0, Lchat/ola/vn/h;->H:S

    if-nez v0, :cond_f

    invoke-static {p1}, Lchat/ola/vn/i/i;->c(Landroid/content/Context;)Landroid/app/Dialog;

    return-void

    :cond_f
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1, p2}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entry/b;)Z

    goto :goto_b

    :sswitch_1b
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_10

    return-void

    :cond_10
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entity/f;

    iget-object v0, p2, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-static {p1, v0}, Lchat/ola/vn/entity/d;->a(Landroid/content/Context;Lchat/ola/vn/entity/d;)V

    iget-object p1, p2, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-virtual {p1}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object p1

    const-string v0, "rss"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_21

    iget-object p1, p2, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-virtual {p1}, Lchat/ola/vn/entity/d;->b()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_11

    iget-object p1, p2, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-virtual {p1}, Lchat/ola/vn/entity/d;->c()Ljava/lang/String;

    move-result-object p1

    :cond_11
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_21

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2, p1, v3, v5}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;S)V

    return-void

    :sswitch_1c
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    if-nez p1, :cond_12

    return-void

    :cond_12
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/f;

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-wide v0, p1, Lchat/ola/vn/entity/f;->c:J

    invoke-virtual {p1}, Lchat/ola/vn/entity/f;->a()Z

    move-result v2

    xor-int/2addr v2, v4

    invoke-virtual {p2, v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(JZ)Z

    move-result p2

    if-nez p2, :cond_13

    return-void

    :cond_13
    invoke-virtual {p1}, Lchat/ola/vn/entity/f;->a()Z

    move-result p2

    if-eqz p2, :cond_14

    invoke-virtual {p1, v5}, Lchat/ola/vn/entity/f;->a(S)V

    iget p2, p1, Lchat/ola/vn/entity/f;->r:I

    sub-int/2addr p2, v4

    iput p2, p1, Lchat/ola/vn/entity/f;->r:I

    iget p2, p1, Lchat/ola/vn/entity/f;->r:I

    if-gez p2, :cond_d

    iput v5, p1, Lchat/ola/vn/entity/f;->r:I

    goto/16 :goto_b

    :cond_14
    invoke-virtual {p1, v4}, Lchat/ola/vn/entity/f;->a(S)V

    iget p2, p1, Lchat/ola/vn/entity/f;->r:I

    add-int/2addr p2, v4

    iput p2, p1, Lchat/ola/vn/entity/f;->r:I

    goto/16 :goto_b

    :sswitch_1d
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_15

    return-void

    :cond_15
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/f;

    iget-object v1, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_16

    iget-object v1, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v1

    packed-switch v1, :pswitch_data_1

    return-void

    :pswitch_2
    iget-object p2, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    goto/16 :goto_8

    :pswitch_3
    iget-object p2, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_7

    goto/16 :goto_4

    :pswitch_4
    :try_start_1
    new-instance v1, Lchat/ola/vn/entity/g;

    invoke-direct {v1}, Lchat/ola/vn/entity/g;-><init>()V

    invoke-virtual {v1, v5}, Lchat/ola/vn/entity/g;->a(B)V

    iget-wide v6, v0, Lchat/ola/vn/entity/f;->c:J

    invoke-virtual {v1, v6, v7}, Lchat/ola/vn/entity/g;->b(J)V

    iget-object v2, v0, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lchat/ola/vn/entity/g;->a(Ljava/lang/String;)V

    iget-object v2, v0, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/entity/g;->b(Ljava/lang/String;)V

    iget v2, v0, Lchat/ola/vn/entity/f;->t:I

    invoke-virtual {v1, v2}, Lchat/ola/vn/entity/g;->b(I)V

    iget v2, v0, Lchat/ola/vn/entity/f;->r:I

    invoke-virtual {v1, v2}, Lchat/ola/vn/entity/g;->a(I)V

    invoke-virtual {v0}, Lchat/ola/vn/entity/f;->c()S

    move-result v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object v2, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lchat/ola/vn/entity/g;->c(Ljava/lang/String;)V

    new-instance v2, Lchat/ola/vn/entry/b;

    invoke-direct {v2, v1}, Lchat/ola/vn/entry/b;-><init>(Lchat/ola/vn/entity/g;)V

    invoke-static {p1, p2, v5, v2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    :try_start_2
    new-instance p2, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object v1, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    iget-object v2, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result v2

    invoke-direct {p2, v1, v2, v4}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v0, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    new-array v1, v4, [Lchat/ola/vn/mediastore/OlaMediaEntity;

    aput-object p2, v1, v5

    invoke-static {p1, v3, v0, v5, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;I[Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    return-void

    :cond_16
    iget-object v1, v0, Lchat/ola/vn/entity/f;->o:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_17

    iget-object p2, v0, Lchat/ola/vn/entity/f;->o:Ljava/lang/String;

    goto/16 :goto_5

    :cond_17
    iget-object v1, v0, Lchat/ola/vn/entity/f;->n:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_7

    if-nez v1, :cond_21

    :try_start_3
    check-cast p1, Lchat/ola/vn/c;

    iget-object v0, v0, Lchat/ola/vn/entity/f;->n:Ljava/lang/String;

    invoke-virtual {p2}, Landroid/view/View;->getTop()I

    move-result p2

    invoke-static {p1, v0, v5, p2}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;II)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    return-void

    :catch_2
    move-exception p1

    :try_start_4
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    :sswitch_1e
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_18

    return-void

    :cond_18
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    iget-object v0, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->A()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-lez v4, :cond_19

    goto/16 :goto_2

    :cond_19
    iget-object v0, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-boolean v0, v0, Lchat/ola/vn/entity/g;->c:Z

    if-eqz v0, :cond_21

    iget-object p2, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;J)V

    return-void

    :sswitch_1f
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/k;

    iget-object v1, v0, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1a

    iget-object v0, v0, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    goto/16 :goto_6

    :cond_1a
    iget-object p2, v0, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_21

    iget-object p2, v0, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {p1, p2}, Lchat/ola/vn/util/b;->n(Landroid/content/Context;Ljava/lang/String;)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, v0, Lchat/ola/vn/entity/k;->g:Ljava/lang/String;

    :goto_c
    const-string v0, "wap"

    invoke-virtual {p1, p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :sswitch_20
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entity/k;

    iget-object v0, p2, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_21

    iget-object v0, p2, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->n(Landroid/content/Context;Ljava/lang/String;)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p2, Lchat/ola/vn/entity/k;->g:Ljava/lang/String;

    goto :goto_c

    :sswitch_21
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_1b

    return-void

    :cond_1b
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entry/b;

    iget-object v0, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->s()Lchat/ola/vn/entity/d;

    move-result-object v0
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_7

    if-nez v0, :cond_1c

    :try_start_5
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->u()Ljava/lang/String;

    move-result-object v1

    const-string v2, "viewme"

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0

    goto/16 :goto_9

    :cond_1c
    :try_start_6
    iget-object v0, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->s()Lchat/ola/vn/entity/d;

    move-result-object v0
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_7

    :try_start_7
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->u()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, p2, v2}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_3

    :catch_3
    :cond_1d
    :try_start_8
    invoke-static {p1, v0}, Lchat/ola/vn/entity/d;->a(Landroid/content/Context;Lchat/ola/vn/entity/d;)V

    return-void

    :sswitch_22
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->s()Lchat/ola/vn/entity/d;

    move-result-object v1

    if-eqz v1, :cond_1f

    invoke-virtual {v1}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_7

    if-eqz v2, :cond_1e

    goto :goto_d

    :cond_1e
    :try_start_9
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->u()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p2, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_4

    :catch_4
    :try_start_a
    invoke-static {p1, v1}, Lchat/ola/vn/entity/d;->a(Landroid/content/Context;Lchat/ola/vn/entity/d;)V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_7

    return-void

    :cond_1f
    :goto_d
    :try_start_b
    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v3, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->u()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v3, v1}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_5

    :catch_5
    :try_start_c
    invoke-static {p1, p2, v5, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_23
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/d;
    :try_end_c
    .catch Ljava/lang/Throwable; {:try_start_c .. :try_end_c} :catch_7

    :try_start_d
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/entity/d;->g()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_d
    .catch Ljava/lang/Throwable; {:try_start_d .. :try_end_d} :catch_6

    :catch_6
    :try_start_e
    invoke-virtual {v0}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v1

    const-string v2, "like"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_20

    invoke-virtual {v0}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v1

    const-string v2, "likeadme"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1d

    :cond_20
    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;Lchat/ola/vn/entity/d;)V
    :try_end_e
    .catch Ljava/lang/Throwable; {:try_start_e .. :try_end_e} :catch_7

    :catch_7
    :cond_21
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f09003b -> :sswitch_23
        0x7f09003c -> :sswitch_23
        0x7f09003d -> :sswitch_23
        0x7f090045 -> :sswitch_22
        0x7f090047 -> :sswitch_21
        0x7f090048 -> :sswitch_20
        0x7f09004d -> :sswitch_20
        0x7f090052 -> :sswitch_1f
        0x7f090056 -> :sswitch_1e
        0x7f090074 -> :sswitch_1d
        0x7f090077 -> :sswitch_1c
        0x7f090079 -> :sswitch_1b
        0x7f0900a5 -> :sswitch_1a
        0x7f0900a6 -> :sswitch_19
        0x7f0900f2 -> :sswitch_18
        0x7f0900f4 -> :sswitch_17
        0x7f0900f5 -> :sswitch_16
        0x7f0900f6 -> :sswitch_15
        0x7f0900f7 -> :sswitch_14
        0x7f0900f8 -> :sswitch_13
        0x7f0901b9 -> :sswitch_12
        0x7f09027a -> :sswitch_11
        0x7f09027b -> :sswitch_11
        0x7f09028e -> :sswitch_10
        0x7f090292 -> :sswitch_f
        0x7f090293 -> :sswitch_e
        0x7f090295 -> :sswitch_d
        0x7f090307 -> :sswitch_d
        0x7f09033a -> :sswitch_10
        0x7f090348 -> :sswitch_c
        0x7f090349 -> :sswitch_b
        0x7f09034a -> :sswitch_a
        0x7f09034b -> :sswitch_9
        0x7f09034c -> :sswitch_8
        0x7f0903e7 -> :sswitch_12
        0x7f0904a7 -> :sswitch_12
        0x7f0904eb -> :sswitch_7
        0x7f090503 -> :sswitch_6
        0x7f090545 -> :sswitch_11
        0x7f090546 -> :sswitch_11
        0x7f09054a -> :sswitch_5
        0x7f09054e -> :sswitch_4
        0x7f090550 -> :sswitch_10
        0x7f090559 -> :sswitch_3
        0x7f0905d0 -> :sswitch_6
        0x7f0905e6 -> :sswitch_2
        0x7f0905e7 -> :sswitch_1
        0x7f0905ec -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method public b_()V
    .locals 0

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    return-void
.end method
