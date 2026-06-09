.class public Lchat/ola/vn/m/w;
.super Lchat/ola/vn/m/q;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Landroid/widget/AdapterView$OnItemLongClickListener;
.implements Lchat/ola/vn/b/j$a;


# instance fields
.field private b:Landroid/widget/ListView;

.field private d:Lchat/ola/vn/b/g;

.field private e:Landroid/view/View;

.field private f:Landroid/view/View;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/EditText;

.field private i:Landroid/widget/TextView;

.field private j:Landroid/view/View;

.field private k:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/m/q;-><init>()V

    new-instance v0, Lchat/ola/vn/m/w$6;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/w$6;-><init>(Lchat/ola/vn/m/w;)V

    iput-object v0, p0, Lchat/ola/vn/m/w;->k:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/w;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/m/w;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/w;->e(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/m/w;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/w;->j:Landroid/view/View;

    return-object p0
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

    new-instance v2, Lchat/ola/vn/m/w$10;

    invoke-direct {v2, p0, p1}, Lchat/ola/vn/m/w$10;-><init>(Lchat/ola/vn/m/w;Lchat/ola/vn/entity/e;)V

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/b;)V

    :cond_1
    return-void
.end method

.method static synthetic c(Lchat/ola/vn/m/w;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/w;->e:Landroid/view/View;

    return-object p0
.end method

.method private e(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mall/search?q="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "UTF-8"

    invoke-static {p1, v1}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/m/w;->f(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private f(Ljava/lang/String;)V
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    iget-object v0, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->clearFocus()V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/w;->e:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/m/w$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/w$2;-><init>(Lchat/ola/vn/m/w;)V

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public B()Z
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->k()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->h()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->n()Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :catch_0
    :cond_0
    return v0
.end method

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

    iput-object p1, p0, Lchat/ola/vn/m/w;->c:Ljava/util/ArrayList;

    new-instance p1, Lchat/ola/vn/mediastore/a;

    invoke-direct {p1}, Lchat/ola/vn/mediastore/a;-><init>()V

    const v0, 0x7f080640

    iput v0, p1, Lchat/ola/vn/mediastore/a;->b:I

    const v0, 0x7f090328

    iput v0, p1, Lchat/ola/vn/mediastore/a;->a:I

    new-instance v0, Lchat/ola/vn/m/w$7;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/w$7;-><init>(Lchat/ola/vn/m/w;)V

    iput-object v0, p1, Lchat/ola/vn/mediastore/a;->f:Landroid/view/View$OnClickListener;

    const/4 v0, 0x1

    iput-boolean v0, p1, Lchat/ola/vn/mediastore/a;->e:Z

    iget-object v0, p0, Lchat/ola/vn/m/w;->c:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/m/w;->c:Ljava/util/ArrayList;

    return-object p1
.end method

.method public a(Lchat/ola/vn/entity/e;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/m/q;->a(Lchat/ola/vn/entity/e;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->v()V

    return-void
.end method

.method public a_(I)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-direct {p0, p1}, Lchat/ola/vn/m/w;->b(Lchat/ola/vn/entity/e;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/m/q;->b(Landroid/os/Bundle;)V

    new-instance p1, Lchat/ola/vn/b/g;

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/g;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/w;->d:Lchat/ola/vn/b/g;

    iget-object p1, p0, Lchat/ola/vn/m/w;->d:Lchat/ola/vn/b/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/g;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/w;->d:Lchat/ola/vn/b/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/g;->a(Landroid/view/View$OnLongClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/w;->d:Lchat/ola/vn/b/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/g;->a(Lchat/ola/vn/b/j$a;)V

    iget-object p1, p0, Lchat/ola/vn/m/w;->b:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/w;->d:Lchat/ola/vn/b/g;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    new-instance p1, Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance v0, Landroid/widget/AbsListView$LayoutParams;

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f0700ed

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    const/4 v2, -0x1

    invoke-direct {v0, v2, v1}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lchat/ola/vn/m/w;->b:Landroid/widget/ListView;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {v0, p1, v1, v2}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;Ljava/lang/Object;Z)V

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->v()V

    return-void
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public g_()Z
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    invoke-super {p0}, Lchat/ola/vn/m/q;->g_()Z

    move-result v0

    return v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 4

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    iget-object p1, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->O()Lchat/ola/vn/entity/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->O()Lchat/ola/vn/entity/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/m/w;->f(Ljava/lang/String;)V

    return-void

    :sswitch_1
    invoke-virtual {p0}, Lchat/ola/vn/m/w;->c()V

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/m/w;->v()V

    return-void

    :sswitch_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->E()I

    move-result v1

    const/16 v2, 0x65

    if-ne v1, v2, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->e()Lchat/ola/vn/m/g;

    move-result-object p1

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/m/g;->f(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->A()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->G()S

    move-result v3

    invoke-static {v1, p1, v2, v3}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;S)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->z(Ljava/lang/String;)V

    return-void

    :sswitch_3
    iget-object v0, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->length()I

    move-result v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/m/w;->e(Ljava/lang/String;)V

    goto :goto_1

    :sswitch_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://mall.ola.vn/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "\n "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_1
    :goto_1
    :sswitch_5
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->a()Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_2

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

    goto :goto_2

    :cond_2
    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/e;->a(Z)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->b()I

    move-result v0

    add-int/2addr v0, v1

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->a(I)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Z)V

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->I()V

    goto/16 :goto_0

    :sswitch_6
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->e()Lchat/ola/vn/m/g;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object p1

    new-instance v2, Lchat/ola/vn/m/w$5;

    invoke-direct {v2, p0}, Lchat/ola/vn/m/w$5;-><init>(Lchat/ola/vn/m/w;)V

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f0900e6 -> :sswitch_6
        0x7f0900e7 -> :sswitch_5
        0x7f0900e8 -> :sswitch_4
        0x7f0900ec -> :sswitch_3
        0x7f0902b0 -> :sswitch_2
        0x7f0902f9 -> :sswitch_1
        0x7f09053f -> :sswitch_0
    .end sparse-switch
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2

    const/4 p3, 0x0

    const v0, 0x7f0b00de

    invoke-virtual {p1, v0, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    const v0, 0x7f09032c

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/w;->e:Landroid/view/View;

    const v0, 0x7f09053f

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/m/w;->g:Landroid/widget/TextView;

    const v0, 0x7f090320

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/m/w;->b:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/w;->b:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/m/w;->b:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemLongClickListener(Landroid/widget/AdapterView$OnItemLongClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/m/w;->b:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/m/w$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/w$1;-><init>(Lchat/ola/vn/m/w;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    const/4 v0, 0x0

    const v1, 0x7f0b00d1

    invoke-virtual {p1, v1, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/w;->f:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/m/w;->f:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/w;->b:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/m/w;->f:Landroid/view/View;

    invoke-virtual {p1, v1, v0, p3}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;Ljava/lang/Object;Z)V

    const p1, 0x7f09053e

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    const p1, 0x7f09058a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/m/w;->i:Landroid/widget/TextView;

    const p1, 0x7f0902ff

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/w;->j:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/m/w;->g:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0900ec

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    new-instance p3, Lchat/ola/vn/m/w$3;

    invoke-direct {p3, p0}, Lchat/ola/vn/m/w$3;-><init>(Lchat/ola/vn/m/w;)V

    invoke-virtual {p1, p3}, Landroid/widget/EditText;->post(Ljava/lang/Runnable;)Z

    iget-object p1, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    new-instance p3, Lchat/ola/vn/m/w$4;

    invoke-direct {p3, p0}, Lchat/ola/vn/m/w$4;-><init>(Lchat/ola/vn/m/w;)V

    invoke-virtual {p1, p3}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    return-object p2
.end method

.method public onDetach()V
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    invoke-super {p0}, Lchat/ola/vn/m/q;->onDetach()V

    return-void
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
    invoke-virtual {p0}, Lchat/ola/vn/m/w;->c()V

    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/m/w;->h:Landroid/widget/EditText;

    const/4 p4, 0x0

    invoke-static {p2, p3, p4}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->e()Lchat/ola/vn/m/g;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object p1

    new-instance p4, Lchat/ola/vn/m/w$8;

    invoke-direct {p4, p0}, Lchat/ola/vn/m/w$8;-><init>(Lchat/ola/vn/m/w;)V

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

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->e()Lchat/ola/vn/m/g;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object p1

    new-instance p4, Lchat/ola/vn/m/w$9;

    invoke-direct {p4, p0}, Lchat/ola/vn/m/w$9;-><init>(Lchat/ola/vn/m/w;)V

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

    invoke-virtual {p0}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Lchat/ola/vn/entity/e;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    const/4 p1, 0x0

    return p1
.end method

.method protected v()V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    if-eqz v0, :cond_b

    iget-object v0, p0, Lchat/ola/vn/m/w;->d:Lchat/ola/vn/b/g;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/w;->d:Lchat/ola/vn/b/g;

    iget-object v1, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->K()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/g;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/m/w;->d:Lchat/ola/vn/b/g;

    invoke-virtual {v0}, Lchat/ola/vn/b/g;->notifyDataSetChanged()V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/w;->e:Landroid/view/View;

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->k()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/w;->e:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/w;->e:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/m/w;->f:Landroid/view/View;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->h()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/m/w;->f:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/m/w;->f:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_4
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/m/w;->j:Landroid/view/View;

    if-eqz v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->L()I

    move-result v0

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/m/w;->j:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto/16 :goto_3

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/m/w;->i:Landroid/widget/TextView;

    if-eqz v0, :cond_6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v3}, Lchat/ola/vn/entity/e;->L()I

    move-result v3

    int-to-long v3, v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v4, 0x7f0f05f2

    invoke-virtual {p0, v4}, Lchat/ola/vn/m/w;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " ("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v4}, Lchat/ola/vn/entity/e;->M()I

    move-result v4

    int-to-float v4, v4

    const/high16 v5, 0x447a0000    # 1000.0f

    div-float/2addr v4, v5

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v4, "s )"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/m/w;->i:Landroid/widget/TextView;

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/m/w;->g:Landroid/widget/TextView;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->O()Lchat/ola/vn/entity/e;

    move-result-object v0

    if-eqz v0, :cond_7

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Landroid/text/SpannableStringBuilder;

    const v3, 0x7f0f0344

    invoke-virtual {p0, v3}, Lchat/ola/vn/m/w;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    const-string v3, " : "

    invoke-virtual {v1, v3}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    invoke-virtual {v1, v0}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    new-instance v3, Landroid/text/style/ForegroundColorSpan;

    const v4, -0xffff01

    invoke-direct {v3, v4}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v4

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    sub-int/2addr v4, v0

    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v0

    const/16 v5, 0x21

    invoke-virtual {v1, v3, v4, v0, v5}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    iget-object v0, p0, Lchat/ola/vn/m/w;->g:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/m/w;->g:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    :cond_7
    iget-object v0, p0, Lchat/ola/vn/m/w;->g:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_8
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/m/w;->j:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/w;->j:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/m/w;->k:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z

    iget-object v0, p0, Lchat/ola/vn/m/w;->j:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/m/w;->k:Ljava/lang/Runnable;

    const-wide/16 v3, 0x1388

    invoke-virtual {v0, v1, v3, v4}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z

    iget-object v0, p0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    iget-object v1, p0, Lchat/ola/vn/m/w;->b:Landroid/widget/ListView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Landroid/widget/ListView;)V

    :cond_9
    :goto_3
    invoke-virtual {p0}, Lchat/ola/vn/m/w;->B()Z

    move-result v0

    if-eqz v0, :cond_a

    iget-object v0, p0, Lchat/ola/vn/m/w;->f:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_a
    iget-object v0, p0, Lchat/ola/vn/m/w;->f:Landroid/view/View;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_b
    return-void
.end method
