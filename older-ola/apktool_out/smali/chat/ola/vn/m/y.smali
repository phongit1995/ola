.class public Lchat/ola/vn/m/y;
.super Lchat/ola/vn/m/c;

# interfaces
.implements Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;
.implements Landroid/view/View$OnLongClickListener;
.implements Landroid/widget/AdapterView$OnItemLongClickListener;
.implements Lchat/ola/vn/b/j$a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/m/y$a;
    }
.end annotation


# instance fields
.field protected d:Landroid/widget/EditText;

.field private e:Lchat/ola/vn/view/OlaListView;

.field private f:Lchat/ola/vn/b/ah;

.field private g:Landroid/view/animation/Animation;

.field private h:F

.field private i:Landroid/support/v4/widget/SwipeRefreshLayout;

.field private j:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/m/c;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/m/y;->j:Z

    return-void
.end method

.method private A()V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->a()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-ltz v4, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    new-instance v1, Lchat/ola/vn/m/y$2;

    invoke-direct {v1, p0, v0}, Lchat/ola/vn/m/y$2;-><init>(Lchat/ola/vn/m/y;Lchat/ola/vn/entity/t;)V

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/entity/t;->b(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->c()V

    iget-object v0, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    invoke-virtual {v0}, Lchat/ola/vn/b/ah;->notifyDataSetChanged()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v3

    const-wide/16 v5, 0x0

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v7

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(JJS)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private C()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/m/y;->j:Z

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->s:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/m/y;->j:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/m/y;->j:Z

    :cond_1
    return-void
.end method

.method private D()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/m/y;->j:Z

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/m/y;->j:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/m/y;->j:Z

    :cond_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/y;)Lchat/ola/vn/view/OlaListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/y;->e:Lchat/ola/vn/view/OlaListView;

    return-object p0
.end method

.method private a(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 9

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_0

    return-void

    :cond_0
    iget-object v5, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    const v0, 0x7f0f069f

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f0465

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f0491

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f0493

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v7, Lchat/ola/vn/i/m;

    invoke-direct {v7, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v7, v2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v8, Lchat/ola/vn/m/y$14;

    move-object v0, v8

    move-object v1, p0

    move-object v3, p1

    move-object v6, p2

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/m/y$14;-><init>(Lchat/ola/vn/m/y;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/g;Lchat/ola/vn/entry/b;)V

    invoke-virtual {v7, v8}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v7}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private a(Landroid/view/View;Lchat/ola/vn/entry/b;)V
    .locals 6

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v1

    iget-object v3, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

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
    iget-object v0, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->f()I

    move-result v0

    iget-object v1, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->i()S

    move-result v1

    if-ne v1, v5, :cond_2

    iget-object p1, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1, v4}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object p1, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    sub-int/2addr v0, v5

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/g;->a(I)V

    goto :goto_1

    :cond_2
    iget-object v1, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1, v5}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object p2, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    add-int/2addr v0, v5

    invoke-virtual {p2, v0}, Lchat/ola/vn/entity/g;->a(I)V

    const p2, 0x7f09054b

    :try_start_0
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/m/y;->g:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    invoke-virtual {p1}, Lchat/ola/vn/b/ah;->notifyDataSetChanged()V

    return-void
.end method

.method private a(Landroid/view/View;Ljava/util/List;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/View;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Lcom/mg/ola/common/c/b;

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/mg/ola/common/c/b;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/c/b;->a(Z)V

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

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

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    const v4, 0x7f080717

    const-string v5, ""

    invoke-direct {v2, v3, v4, v5}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    goto :goto_1

    :pswitch_1
    new-instance v2, Lcom/mg/ola/common/c/a;

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    const v4, 0x7f08071a

    const-string v5, ""

    invoke-direct {v2, v3, v4, v5}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    goto :goto_1

    :pswitch_2
    new-instance v2, Lcom/mg/ola/common/c/a;

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    const v4, 0x7f080714

    const-string v5, ""

    invoke-direct {v2, v3, v4, v5}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    :goto_1
    invoke-virtual {v0, v2}, Lcom/mg/ola/common/c/b;->a(Lcom/mg/ola/common/c/a;)V

    goto :goto_0

    :cond_0
    new-instance v1, Lchat/ola/vn/m/y$13;

    invoke-direct {v1, p0, p2}, Lchat/ola/vn/m/y$13;-><init>(Lchat/ola/vn/m/y;Ljava/util/List;)V

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/c/b;->a(Lcom/mg/ola/common/c/c$a;)V

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/c/b;->a(Landroid/view/View;)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private a(Lchat/ola/vn/entry/b;)V
    .locals 5

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/e;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->c()I

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    :cond_0
    iget-object v0, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

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

    iget-object v1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/i;->a(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    move-object v0, v1

    :cond_2
    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "@"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v3

    invoke-static {v1, v2, v0, v3, v4}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/y;Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/y;->a(Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/y;Landroid/view/View;Lchat/ola/vn/entry/b;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/y;->a(Landroid/view/View;Lchat/ola/vn/entry/b;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/y;Landroid/view/View;Ljava/util/List;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/y;->a(Landroid/view/View;Ljava/util/List;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/y;Lchat/ola/vn/entry/b;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/y;->a(Lchat/ola/vn/entry/b;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/y;Lchat/ola/vn/message/f;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/y;->a(Lchat/ola/vn/message/f;Ljava/lang/String;)V

    return-void
.end method

.method private a(Lchat/ola/vn/message/f;Ljava/lang/String;)V
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0492

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0493

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f043c

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f042f

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/i/m;->setTitle(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    invoke-virtual {v1, p2}, Lchat/ola/vn/i/m;->a(Ljava/lang/String;)V

    :goto_0
    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance p1, Lchat/ola/vn/m/y$4;

    invoke-direct {p1, p0, v0, p2}, Lchat/ola/vn/m/y$4;-><init>(Lchat/ola/vn/m/y;Ljava/util/List;Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/m/y;)F
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/y;->y()F

    move-result p0

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/m/y;)Lchat/ola/vn/b/ah;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/m/y;)Landroid/view/animation/Animation;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/y;->g:Landroid/view/animation/Animation;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/m/y;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/y;->z()V

    return-void
.end method

.method private e(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v2, 0x0

    invoke-virtual {v1, p1, v2}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v1

    if-nez v1, :cond_0

    const v2, 0x7f0f0550

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    const v2, 0x7f0f0465

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v2, 0x7f0f06a7

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v2, 0x7f0f056b

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v2, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    invoke-direct {v2, v3}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/i/m;->setTitle(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    invoke-virtual {v2, p1}, Lchat/ola/vn/i/m;->a(Ljava/lang/String;)V

    :goto_0
    invoke-virtual {v2, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v3, Lchat/ola/vn/m/y$3;

    invoke-direct {v3, p0, v0, p1, v1}, Lchat/ola/vn/m/y$3;-><init>(Lchat/ola/vn/m/y;Ljava/util/List;Ljava/lang/String;Lchat/ola/vn/message/f;)V

    invoke-virtual {v2, v3}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v2}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic f(Lchat/ola/vn/m/y;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/y;->D()V

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/m/y;)Landroid/support/v4/widget/SwipeRefreshLayout;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/y;->i:Landroid/support/v4/widget/SwipeRefreshLayout;

    return-object p0
.end method

.method private y()F
    .locals 2

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->d()I

    move-result v0

    sput v0, Lchat/ola/vn/c/x;->i:I

    const/high16 v0, 0x41400000    # 12.0f

    iput v0, p0, Lchat/ola/vn/m/y;->h:F

    sget v0, Lchat/ola/vn/c/x;->i:I

    mul-int/lit8 v0, v0, 0xa

    int-to-float v0, v0

    iget v1, p0, Lchat/ola/vn/m/y;->h:F

    mul-float v0, v0, v1

    const/high16 v1, 0x42c80000    # 100.0f

    div-float/2addr v0, v1

    iget v1, p0, Lchat/ola/vn/m/y;->h:F

    add-float/2addr v1, v0

    return v1
.end method

.method private z()V
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v1

    invoke-static {v0, v1, v2}, Lchat/ola/vn/me/OlaMeComposerActivity;->b(Landroid/content/Context;J)V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->k()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->a()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-gez v0, :cond_1

    const/4 v1, 0x1

    :cond_1
    return v1
.end method

.method public a(Landroid/content/Context;)Ljava/util/ArrayList;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/a;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/m/y;->c:Ljava/util/ArrayList;

    new-instance v0, Lchat/ola/vn/mediastore/a;

    invoke-direct {v0}, Lchat/ola/vn/mediastore/a;-><init>()V

    const v1, 0x7f08063a

    iput v1, v0, Lchat/ola/vn/mediastore/a;->b:I

    const v1, 0x7f09039d

    iput v1, v0, Lchat/ola/vn/mediastore/a;->a:I

    new-instance v2, Lchat/ola/vn/m/y$8;

    invoke-direct {v2, p0}, Lchat/ola/vn/m/y$8;-><init>(Lchat/ola/vn/m/y;)V

    iput-object v2, v0, Lchat/ola/vn/mediastore/a;->f:Landroid/view/View$OnClickListener;

    const/4 v2, 0x1

    iput-boolean v2, v0, Lchat/ola/vn/mediastore/a;->e:Z

    const v3, 0x7f0f0517

    invoke-virtual {p1, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v0, Lchat/ola/vn/mediastore/a;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/m/y;->c:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/mediastore/a;

    invoke-direct {v0}, Lchat/ola/vn/mediastore/a;-><init>()V

    const v3, 0x7f080648

    iput v3, v0, Lchat/ola/vn/mediastore/a;->b:I

    iput v1, v0, Lchat/ola/vn/mediastore/a;->a:I

    new-instance v1, Lchat/ola/vn/m/y$9;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/y$9;-><init>(Lchat/ola/vn/m/y;)V

    iput-object v1, v0, Lchat/ola/vn/mediastore/a;->f:Landroid/view/View$OnClickListener;

    iput-boolean v2, v0, Lchat/ola/vn/mediastore/a;->e:Z

    const v1, 0x7f0f0628

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/mediastore/a;->c:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/m/y;->c:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/m/y;->c:Ljava/util/ArrayList;

    return-object p1
.end method

.method public a(Lchat/ola/vn/entity/t;)V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/y;->h()V

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-super {p0, p1}, Lchat/ola/vn/m/c;->a(Lchat/ola/vn/entity/t;)V

    iget-object v0, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    invoke-virtual {v0, p1}, Lchat/ola/vn/b/ah;->a(Lchat/ola/vn/entity/t;)V

    iget-object p1, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    invoke-virtual {p1}, Lchat/ola/vn/b/ah;->notifyDataSetChanged()V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/entry/b/k;)Z
    .locals 3

    :try_start_0
    iget-object v0, p1, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaTextView;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p1, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    sget v1, Lchat/ola/vn/f;->A:I

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaTextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    invoke-virtual {v0}, Lchat/ola/vn/b/ah;->notifyDataSetChanged()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0491

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0493

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f00fa

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/m/y$5;

    invoke-direct {v2, p0, p1, v0}, Lchat/ola/vn/m/y$5;-><init>(Lchat/ola/vn/m/y;Lchat/ola/vn/entry/b/k;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    new-instance v0, Lchat/ola/vn/m/y$6;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/m/y$6;-><init>(Lchat/ola/vn/m/y;Lchat/ola/vn/entry/b/k;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public a_(I)V
    .locals 6

    iget-object p1, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->a()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-ltz p1, :cond_0

    return-void

    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/y;->x()J

    move-result-wide v3

    iget-object p1, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    new-instance v0, Lchat/ola/vn/m/y$15;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/m/y$15;-><init>(Lchat/ola/vn/m/y;Lchat/ola/vn/entity/t;)V

    invoke-virtual {p1, v3, v4}, Lchat/ola/vn/entity/t;->b(J)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v1

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v5

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/network/OlaNetworkService;->a(JJS)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/m/c;->b(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v0, 0x7f010057

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/y;->g:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/m/y;->g:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x64

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    new-instance p1, Lchat/ola/vn/b/ah;

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/ah;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    iget-object p1, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    invoke-direct {p0}, Lchat/ola/vn/m/y;->y()F

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/ah;->a(F)V

    iget-object p1, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    new-instance v0, Lchat/ola/vn/m/y$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lchat/ola/vn/m/y$a;-><init>(Lchat/ola/vn/m/y;Lchat/ola/vn/m/y$1;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/ah;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/ah;->a(Landroid/view/View$OnLongClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    iget-object v0, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/ah;->a(Lchat/ola/vn/entity/t;)V

    iget-object p1, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/ah;->a(Lchat/ola/vn/b/j$a;)V

    iget-object p1, p0, Lchat/ola/vn/m/y;->e:Lchat/ola/vn/view/OlaListView;

    iget-object v0, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaListView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->d()V

    return-void
.end method

.method public c()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    iget-object v1, p0, Lchat/ola/vn/m/y;->e:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/t;->a(Landroid/widget/ListView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public d()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    invoke-virtual {v0}, Lchat/ola/vn/b/ah;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    iget-object v1, p0, Lchat/ola/vn/m/y;->e:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/t;->b(Landroid/widget/ListView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public d_()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/m/y;->f:Lchat/ola/vn/b/ah;

    invoke-virtual {v0}, Lchat/ola/vn/b/ah;->notifyDataSetChanged()V

    return-void
.end method

.method public h_()Landroid/app/Dialog;
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0491

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f040c

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f04fa

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0623

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/m/y$10;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/m/y$10;-><init>(Lchat/ola/vn/m/y;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-object v1
.end method

.method public i()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public j()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->g()Ljava/util/ArrayList;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 3

    const/4 p3, 0x0

    const v0, 0x7f0b0115

    invoke-virtual {p1, v0, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    const v0, 0x7f090315

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaListView;

    iput-object v0, p0, Lchat/ola/vn/m/y;->e:Lchat/ola/vn/view/OlaListView;

    const v0, 0x7f090451

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/m/y;->d:Landroid/widget/EditText;

    const v0, 0x7f0904ae

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object v0, p0, Lchat/ola/vn/m/y;->i:Landroid/support/v4/widget/SwipeRefreshLayout;

    iget-object v0, p0, Lchat/ola/vn/m/y;->i:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v0, p0}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    iget-object v0, p0, Lchat/ola/vn/m/y;->i:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x1

    new-array v1, v1, [I

    const v2, 0x7f06003d

    aput v2, v1, p3

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    iget-object p3, p0, Lchat/ola/vn/m/y;->e:Lchat/ola/vn/view/OlaListView;

    new-instance v0, Lchat/ola/vn/m/y$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/y$1;-><init>(Lchat/ola/vn/m/y;)V

    invoke-virtual {p3, v0}, Lchat/ola/vn/view/OlaListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    iget-object p3, p0, Lchat/ola/vn/m/y;->e:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/y;->a(Landroid/view/LayoutInflater;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p3, p1}, Lchat/ola/vn/view/OlaListView;->addHeaderView(Landroid/view/View;)V

    return-object p2
.end method

.method public onItemLongClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)Z
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)Z"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    if-eqz p1, :cond_0

    instance-of p2, p1, Lchat/ola/vn/entry/b/k;

    if-eqz p2, :cond_0

    check-cast p1, Lchat/ola/vn/entry/b/k;

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/y;->a(Lchat/ola/vn/entry/b/k;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 6

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f09033a

    const/4 v2, 0x1

    if-eq v0, v1, :cond_2

    const v1, 0x7f09054e

    if-eq v0, v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->i()S

    move-result v1

    if-eq v1, v2, :cond_1

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/m/y;->a(Landroid/view/View;Lchat/ola/vn/entry/b;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v1, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v1

    const v3, 0x7f0f0367

    invoke-virtual {p0, v3}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v4

    invoke-static {p1, v1, v3, v4, v5}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)V

    :cond_1
    return v2

    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/m/y;->e(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v2

    :catch_0
    :goto_0
    const/4 p1, 0x0

    return p1
.end method

.method public onRefresh()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/y;->i:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    invoke-direct {p0}, Lchat/ola/vn/m/y;->C()V

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->f()Lchat/ola/vn/m/j;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    new-instance v2, Lchat/ola/vn/m/y$7;

    invoke-direct {v2, p0}, Lchat/ola/vn/m/y$7;-><init>(Lchat/ola/vn/m/y;)V

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public onResume()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/m/c;->onResume()V

    invoke-direct {p0}, Lchat/ola/vn/m/y;->A()V

    return-void
.end method

.method public v()V
    .locals 3

    new-instance v0, Lchat/ola/vn/i/n;

    invoke-virtual {p0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->requestWindowFeature(I)Z

    const v2, 0x7f0b00a9

    invoke-virtual {v0, v2}, Lchat/ola/vn/i/n;->setContentView(I)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->setCanceledOnTouchOutside(Z)V

    invoke-virtual {v0}, Lchat/ola/vn/i/n;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    const/4 v2, -0x1

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    const v1, 0x7f090561

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    const/high16 v2, 0x41400000    # 12.0f

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V

    const v1, 0x7f090544

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    const/high16 v2, 0x41c00000    # 24.0f

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V

    const v1, 0x7f090477

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/SeekBar;

    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Landroid/widget/SeekBar;->setMax(I)V

    sget v2, Lchat/ola/vn/c/x;->i:I

    invoke-virtual {v1, v2}, Landroid/widget/SeekBar;->setProgress(I)V

    new-instance v2, Lchat/ola/vn/m/y$11;

    invoke-direct {v2, p0}, Lchat/ola/vn/m/y$11;-><init>(Lchat/ola/vn/m/y;)V

    invoke-virtual {v1, v2}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    new-instance v1, Lchat/ola/vn/m/y$12;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/y$12;-><init>(Lchat/ola/vn/m/y;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/n;->show()V

    return-void
.end method

.method public x()J
    .locals 4

    const-wide/16 v0, 0x0

    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v2}, Lchat/ola/vn/entity/t;->d()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v2}, Lchat/ola/vn/entity/t;->d()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    return-wide v0

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v2}, Lchat/ola/vn/entity/t;->d()Ljava/util/List;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->d()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v2

    :catch_0
    :cond_1
    return-wide v0
.end method
