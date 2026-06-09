.class public Lchat/ola/vn/m/v;
.super Lchat/ola/vn/m/q;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Landroid/widget/AdapterView$OnItemLongClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/m/v$a;
    }
.end annotation


# instance fields
.field private b:Landroid/widget/ListView;

.field private d:Lchat/ola/vn/b/g;

.field private e:Lchat/ola/vn/b/e;

.field private f:Lchat/ola/vn/b/f;

.field private g:Landroid/view/View;

.field private h:Lchat/ola/vn/entry/b/h;

.field private i:Landroid/widget/LinearLayout;

.field private j:Landroid/view/animation/Animation;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/q;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/v;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/v;->g:Landroid/view/View;

    return-object p0
.end method

.method private a(JJ)V
    .locals 8

    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    if-nez v2, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->k()Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Z)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/m/v;->g:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v0, Lchat/ola/vn/m/v$13;

    invoke-direct {v0, p0, p3, p4}, Lchat/ola/vn/m/v$13;-><init>(Lchat/ola/vn/m/v;J)V

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v7

    move-wide v3, p1

    move-wide v5, p3

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(JJS)V

    return-void
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

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/v;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f0465

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/v;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f0491

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/v;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f0493

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/v;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v7, Lchat/ola/vn/i/m;

    invoke-direct {v7, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v7, v2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v8, Lchat/ola/vn/m/v$6;

    move-object v0, v8

    move-object v1, p0

    move-object v3, p1

    move-object v6, p2

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/m/v$6;-><init>(Lchat/ola/vn/m/v;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/g;Lchat/ola/vn/entry/b;)V

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

    iget-object p2, p0, Lchat/ola/vn/m/v;->j:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    invoke-virtual {p1}, Lchat/ola/vn/b/g;->notifyDataSetChanged()V

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

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

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

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    const v4, 0x7f080717

    const-string v5, ""

    invoke-direct {v2, v3, v4, v5}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    goto :goto_1

    :pswitch_1
    new-instance v2, Lcom/mg/ola/common/c/a;

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    const v4, 0x7f08071a

    const-string v5, ""

    invoke-direct {v2, v3, v4, v5}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    goto :goto_1

    :pswitch_2
    new-instance v2, Lcom/mg/ola/common/c/a;

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    const v4, 0x7f080714

    const-string v5, ""

    invoke-direct {v2, v3, v4, v5}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    :goto_1
    invoke-virtual {v0, v2}, Lcom/mg/ola/common/c/b;->a(Lcom/mg/ola/common/c/a;)V

    goto :goto_0

    :cond_0
    new-instance v1, Lchat/ola/vn/m/v$7;

    invoke-direct {v1, p0, p2}, Lchat/ola/vn/m/v$7;-><init>(Lchat/ola/vn/m/v;Ljava/util/List;)V

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

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/i;->a(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    iget-object v2, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v2

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v3

    invoke-static {v1, v2, v0, v3, v4}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/v;JJ)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/m/v;->a(JJ)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/v;Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/v;->a(Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/v;Landroid/view/View;Lchat/ola/vn/entry/b;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/v;->a(Landroid/view/View;Lchat/ola/vn/entry/b;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/v;Landroid/view/View;Ljava/util/List;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/v;->a(Landroid/view/View;Ljava/util/List;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/v;Lchat/ola/vn/entity/e;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/v;->b(Lchat/ola/vn/entity/e;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/v;Lchat/ola/vn/entry/b;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/v;->a(Lchat/ola/vn/entry/b;)V

    return-void
.end method

.method private b(Lchat/ola/vn/entity/e;)V
    .locals 3

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->h()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->k()Z

    move-result v1

    if-eqz v1, :cond_0

    return-void

    :cond_0
    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/e;->b(Z)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v2, Lchat/ola/vn/m/v$2;

    invoke-direct {v2, p0, p1}, Lchat/ola/vn/m/v$2;-><init>(Lchat/ola/vn/m/v;Lchat/ola/vn/entity/e;)V

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/b;)V

    :cond_1
    return-void
.end method

.method private x()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->R()I

    move-result v0

    const/4 v1, 0x2

    const/4 v2, 0x1

    const/4 v3, 0x0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/m/v;->i:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->i:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->i:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->x()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    iget-object v1, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->x()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/g;->b(Ljava/util/List;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    iget-object v1, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->w()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/g;->a(Ljava/util/List;)V

    :cond_1
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/m/v;->f:Lchat/ola/vn/b/f;

    iget-object v1, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/f;->a(Landroid/widget/BaseAdapter;)V

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/m/v;->f:Lchat/ola/vn/b/f;

    invoke-virtual {v0}, Lchat/ola/vn/b/f;->notifyDataSetChanged()V

    return-void

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/m/v;->i:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->i:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->i:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    iget-object v1, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->P()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/g;->a(Ljava/util/List;)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/m/v;->f:Lchat/ola/vn/b/f;

    iget-object v1, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/f;->a(Landroid/widget/BaseAdapter;)V

    goto :goto_1

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/m/v;->i:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->i:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->i:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->e:Lchat/ola/vn/b/e;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/m/v;->e:Lchat/ola/vn/b/e;

    iget-object v1, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->f()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/e;->a(Ljava/util/List;)V

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/m/v;->f:Lchat/ola/vn/b/f;

    iget-object v1, p0, Lchat/ola/vn/m/v;->e:Lchat/ola/vn/b/e;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/f;->a(Landroid/widget/BaseAdapter;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public a(Landroid/content/Context;)Ljava/util/ArrayList;
    .locals 1
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

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/m/v;->c:Ljava/util/ArrayList;

    new-instance p1, Lchat/ola/vn/mediastore/a;

    invoke-direct {p1}, Lchat/ola/vn/mediastore/a;-><init>()V

    const v0, 0x7f080643

    iput v0, p1, Lchat/ola/vn/mediastore/a;->b:I

    const v0, 0x7f090328

    iput v0, p1, Lchat/ola/vn/mediastore/a;->a:I

    new-instance v0, Lchat/ola/vn/m/v$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/v$3;-><init>(Lchat/ola/vn/m/v;)V

    iput-object v0, p1, Lchat/ola/vn/mediastore/a;->f:Landroid/view/View$OnClickListener;

    const/4 v0, 0x1

    iput-boolean v0, p1, Lchat/ola/vn/mediastore/a;->e:Z

    iget-object v0, p0, Lchat/ola/vn/m/v;->c:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/m/v;->c:Ljava/util/ArrayList;

    return-object p1
.end method

.method public a(Lchat/ola/vn/entity/e;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/m/q;->a(Lchat/ola/vn/entity/e;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->v()V

    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 4

    invoke-super {p0, p1}, Lchat/ola/vn/m/q;->b(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v0, 0x7f010057

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/v;->j:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/m/v;->j:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x64

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    new-instance p1, Lchat/ola/vn/b/g;

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/g;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    iget-object p1, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/g;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/g;->a(Landroid/view/View$OnLongClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    new-instance v0, Lchat/ola/vn/m/v$10;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/v$10;-><init>(Lchat/ola/vn/m/v;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/g;->a(Lchat/ola/vn/b/j$a;)V

    new-instance p1, Lchat/ola/vn/m/v$11;

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/m/v$11;-><init>(Lchat/ola/vn/m/v;Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/v;->e:Lchat/ola/vn/b/e;

    iget-object p1, p0, Lchat/ola/vn/m/v;->e:Lchat/ola/vn/b/e;

    new-instance v0, Lchat/ola/vn/m/v$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lchat/ola/vn/m/v$a;-><init>(Lchat/ola/vn/m/v;Lchat/ola/vn/m/v$1;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/e;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/v;->e:Lchat/ola/vn/b/e;

    new-instance v0, Lchat/ola/vn/m/v$12;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/v$12;-><init>(Lchat/ola/vn/m/v;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/e;->a(Lchat/ola/vn/b/j$a;)V

    new-instance p1, Lchat/ola/vn/b/f;

    iget-object v0, p0, Lchat/ola/vn/m/v;->e:Lchat/ola/vn/b/e;

    iget-object v1, p0, Lchat/ola/vn/m/v;->d:Lchat/ola/vn/b/g;

    invoke-direct {p1, v0, v1}, Lchat/ola/vn/b/f;-><init>(Lchat/ola/vn/b/e;Lchat/ola/vn/b/g;)V

    iput-object p1, p0, Lchat/ola/vn/m/v;->f:Lchat/ola/vn/b/f;

    iget-object p1, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/v;->f:Lchat/ola/vn/b/f;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->B()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    invoke-direct {p0, v0, v1, v2, v3}, Lchat/ola/vn/m/v;->a(JJ)V

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/v;->v()V

    return-void
.end method

.method public c()V
    .locals 2

    :try_start_0
    invoke-super {p0}, Lchat/ola/vn/m/q;->c()V

    iget-object v0, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->R()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    iget-object v1, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->a(Landroid/widget/ListView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public d_()V
    .locals 0

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->v()V

    return-void
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 4

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f090289

    if-eq v0, v1, :cond_4

    const v1, 0x7f0902b0

    if-eq v0, v1, :cond_2

    const v1, 0x7f0902f9

    if-eq v0, v1, :cond_1

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "http://mall.ola.vn/"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v2}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\n "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    :goto_0
    invoke-static {v0, p1, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :pswitch_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "http://mall.ola.vn/"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "\n "

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    goto :goto_0

    :pswitch_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->a()Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->a(Z)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->b()I

    move-result v2

    sub-int/2addr v2, v1

    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/e;->a(I)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Z)V

    goto :goto_1

    :cond_0
    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/e;->a(Z)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->b()I

    move-result v0

    add-int/2addr v0, v1

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->a(I)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Z)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->I()V

    :goto_2
    invoke-virtual {p0}, Lchat/ola/vn/m/v;->v()V

    return-void

    :pswitch_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->e()Lchat/ola/vn/m/g;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object p1

    new-instance v2, Lchat/ola/vn/m/v$15;

    invoke-direct {v2, p0}, Lchat/ola/vn/m/v$15;-><init>(Lchat/ola/vn/m/v;)V

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/m/v;->c()V

    goto :goto_2

    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->E()I

    move-result v1

    const/16 v2, 0x65

    if-ne v1, v2, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->e()Lchat/ola/vn/m/g;

    move-result-object p1

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Lchat/ola/vn/m/v$14;

    invoke-direct {v2, p0}, Lchat/ola/vn/m/v$14;-><init>(Lchat/ola/vn/m/v;)V

    invoke-virtual {p1, v1, v0, v2}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V

    return-void

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->A()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->G()S

    move-result v3

    invoke-static {v1, p1, v2, v3}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    :goto_3
    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->z(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :cond_4
    :try_start_2
    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->A()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v2}, Lchat/ola/vn/entity/e;->G()S

    move-result v2

    invoke-static {v0, p1, v1, v2}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;S)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :try_start_3
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_3

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f0900e6
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 5

    const/4 p3, 0x0

    const v0, 0x7f0b00dc

    invoke-virtual {p1, v0, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f09032c

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/v;->g:Landroid/view/View;

    const p2, 0x7f090320

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ListView;

    iput-object p2, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    iget-object p2, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    invoke-virtual {p2, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    invoke-virtual {p2, p0}, Landroid/widget/ListView;->setOnItemLongClickListener(Landroid/widget/AdapterView$OnItemLongClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    invoke-virtual {p2, p0}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    invoke-static {p2, v0, p3}, Lchat/ola/vn/entry/b/h;->b(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b/h;

    iput-object v0, p0, Lchat/ola/vn/m/v;->h:Lchat/ola/vn/entry/b/h;

    iget-object v0, p0, Lchat/ola/vn/m/v;->h:Lchat/ola/vn/entry/b/h;

    invoke-virtual {v0, p0}, Lchat/ola/vn/entry/b/h;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->h:Lchat/ola/vn/entry/b/h;

    invoke-virtual {v0, p0}, Lchat/ola/vn/entry/b/h;->a(Landroid/view/View$OnLongClickListener;)V

    const v0, 0x7f0900e9

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0900e5

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/m/v$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/v$1;-><init>(Lchat/ola/vn/m/v;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0902f9

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lchat/ola/vn/m/v;->i:Landroid/widget/LinearLayout;

    iget-object v0, p0, Lchat/ola/vn/m/v;->i:Landroid/widget/LinearLayout;

    const v1, 0x7f0900ea

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p3}, Landroid/view/View;->setVisibility(I)V

    new-instance v1, Lchat/ola/vn/m/v$8;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/v$8;-><init>(Lchat/ola/vn/m/v;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0900eb

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/m/v$9;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/v$9;-><init>(Lchat/ola/vn/m/v;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    const/4 v1, 0x0

    invoke-virtual {v0, p2, v1, p3}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;Ljava/lang/Object;Z)V

    new-instance p2, Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p2, v0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance v0, Landroid/widget/AbsListView$LayoutParams;

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x7f070141

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v2

    const/4 v3, -0x1

    invoke-direct {v0, v3, v2}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    invoke-virtual {v0, p2, v1, p3}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;Ljava/lang/Object;Z)V

    new-instance p2, Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p2, v0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance v0, Landroid/widget/AbsListView$LayoutParams;

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v4, 0x7f0700ed

    invoke-virtual {v2, v4}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v2

    invoke-direct {v0, v3, v2}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    invoke-virtual {v0, p2, v1, p3}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;Ljava/lang/Object;Z)V

    return-object p1
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    iget-object p2, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p2}, Lchat/ola/vn/entity/e;->R()I

    move-result p2

    const/4 p3, 0x1

    if-ne p2, p3, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->c()V

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->G()S

    move-result p1

    invoke-static {p2, p3, p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;S)V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/v;->e()Lchat/ola/vn/m/g;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object p1

    new-instance p4, Lchat/ola/vn/m/v$4;

    invoke-direct {p4, p0}, Lchat/ola/vn/m/v$4;-><init>(Lchat/ola/vn/m/v;)V

    invoke-virtual {p2, p3, p1, p4}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
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
    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->e()Lchat/ola/vn/m/g;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object p1

    new-instance p4, Lchat/ola/vn/m/v$5;

    invoke-direct {p4, p0}, Lchat/ola/vn/m/v$5;-><init>(Lchat/ola/vn/m/v;)V

    invoke-virtual {p2, p3, p1, p4}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return p1
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0902b0

    if-eq v0, v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Lchat/ola/vn/entity/e;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    const/4 p1, 0x0

    return p1
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    const/4 p3, 0x0

    invoke-virtual {p1, p3}, Landroid/widget/ListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result p3

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/entity/e;->b(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 0

    return-void
.end method

.method protected v()V
    .locals 2

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/m/v;->x()V

    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/m/v;->g:Landroid/view/View;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->k()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/v;->g:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/v;->g:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/m/v;->h:Lchat/ola/vn/entry/b/h;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/m/v;->h:Lchat/ola/vn/entry/b/h;

    iget-object v1, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/b/h;->a(Lchat/ola/vn/entity/e;)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->R()I

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    iget-object v1, p0, Lchat/ola/vn/m/v;->b:Landroid/widget/ListView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Landroid/widget/ListView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    return-void
.end method
