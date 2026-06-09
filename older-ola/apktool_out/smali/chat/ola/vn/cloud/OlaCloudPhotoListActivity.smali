.class public Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/cloud/d;
.implements Lchat/ola/vn/p/n;


# static fields
.field private static e:Lchat/ola/vn/entity/l;

.field private static f:Ljava/lang/String;


# instance fields
.field private g:Landroid/widget/GridView;

.field private h:Lchat/ola/vn/cloud/b;

.field private i:Landroid/view/View;

.field private j:Landroid/view/View;

.field private k:Landroid/widget/TextView;

.field private l:Ljava/lang/String;

.field private m:Ljava/lang/String;

.field private n:Ljava/lang/Runnable;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->g:Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->i:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->j:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->k:Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->m:Ljava/lang/String;

    return-void
.end method

.method static synthetic E()Lchat/ola/vn/entity/l;
    .locals 1

    sget-object v0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    return-object v0
.end method

.method private F()V
    .locals 3

    const v0, 0x7f09005a

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->g:Landroid/widget/GridView;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->g:Landroid/widget/GridView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a4

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-object v0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    const v1, 0x7f0903a3

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    iget-object v0, v0, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    iget-object v1, v1, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_0
    sget-object v0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v2, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->f:Ljava/lang/String;

    invoke-virtual {v0, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_1
    invoke-virtual {p0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->f:Ljava/lang/String;

    goto :goto_0

    :cond_2
    invoke-virtual {p0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f00ee

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    :goto_1
    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->i:Landroid/view/View;

    const v0, 0x7f0903a1

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->j:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->j:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09039e

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->k:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->k:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private G()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/cloud/b;

    invoke-direct {v0, p0}, Lchat/ola/vn/cloud/b;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0, p0}, Lchat/ola/vn/cloud/b;->a(Lchat/ola/vn/cloud/d;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0, p0}, Lchat/ola/vn/cloud/b;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->g:Landroid/widget/GridView;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->g()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->g()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->notifyDataSetChanged()V

    return-void

    :cond_2
    :goto_0
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a_(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private H()V
    .locals 4

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->J()Z

    move-result v1

    const v2, 0x7f0f0493

    const v3, 0x7f0f0491

    if-eqz v1, :cond_0

    const v1, 0x7f0f05b2

    invoke-virtual {p0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0, v3}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :goto_0
    invoke-virtual {p0, v2}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_0
    invoke-virtual {p0, v3}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :goto_1
    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;-><init>(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private I()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method private J()Z
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->f:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    return v0

    :catch_0
    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method static synthetic a(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;)Lchat/ola/vn/cloud/b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    return-object p0
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/entity/l;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/l;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/l;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/l;)V
    .locals 0

    sput-object p2, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    sput-object p1, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->f:Ljava/lang/String;

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const p2, 0x7f010039

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->c(Z)V

    return-void
.end method

.method private c(Z)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->n:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$3;-><init>(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->n:Ljava/lang/Runnable;

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->n:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->i:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->n:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7530

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->i:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    const-string v1, "null"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public C()V
    .locals 0

    return-void
.end method

.method public D()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->j:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->k:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->G()V

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->c(Z)V

    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->m:Ljava/lang/String;

    return-void
.end method

.method public a(Landroid/view/View;Lchat/ola/vn/entity/i;)V
    .locals 8

    invoke-virtual {p2}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Lchat/ola/vn/entity/i;->f()S

    move-result p2

    packed-switch p2, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-static {p0, v0}, Lchat/ola/vn/util/b;->f(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_1
    invoke-static {p0, v0}, Lchat/ola/vn/util/b;->h(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_2
    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {v1}, Lchat/ola/vn/cloud/b;->g()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_3

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/entity/i;

    invoke-virtual {v5}, Lchat/ola/vn/entity/i;->f()S

    move-result v6

    const/4 v7, 0x1

    if-ne v6, v7, :cond_1

    invoke-virtual {v5}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result v4

    :cond_0
    new-instance v6, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v5}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v6, v5, v7, v7}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    invoke-virtual {p2, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    if-eqz p2, :cond_3

    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_3

    const/4 v0, 0x0

    invoke-static {p0, p1, v0, v4, p2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    return-void

    :cond_3
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a(Lchat/ola/vn/entity/l;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    const/4 p1, 0x0

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->c(Z)V

    iput-object p4, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    invoke-static {p4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    if-eqz p3, :cond_0

    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result p1

    if-nez p1, :cond_1

    :cond_0
    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->m:Ljava/lang/String;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {p1, p3}, Lchat/ola/vn/cloud/b;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    const/4 p1, 0x0

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->c(Z)V

    iput-object p3, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    if-eqz p2, :cond_0

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p1

    if-nez p1, :cond_1

    :cond_0
    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->m:Ljava/lang/String;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {p1, p2}, Lchat/ola/vn/cloud/b;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(Ljava/util/List;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    return-void
.end method

.method public a_(I)V
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->m:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    if-nez p1, :cond_1

    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->c(Z)V

    goto :goto_0

    :cond_1
    invoke-direct {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->c(Z)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->m:Ljava/lang/String;

    const/4 p1, 0x0

    :try_start_0
    sget-object v1, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    iget-object v1, v1, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v4, v1

    goto :goto_1

    :catch_0
    move-object v4, p1

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    const-string v1, "null"

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    return-void

    :cond_2
    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->J()Z

    move-result p1

    if-eqz p1, :cond_3

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/16 v1, 0x32

    iget-object v2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    invoke-virtual {p1, v4, v1, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;BLjava/lang/String;S)V

    return-void

    :cond_3
    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v3, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->f:Ljava/lang/String;

    const/16 v5, 0x32

    iget-object v6, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    const/4 v7, 0x0

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;BLjava/lang/String;S)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->c(Z)V

    iput-object p3, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->l:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {p1, p2}, Lchat/ola/vn/cloud/b;->a(Ljava/util/List;)V

    return-void
.end method

.method public d(I)V
    .locals 4

    if-lez p1, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->I()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->j:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->J()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->k:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const v3, 0x7f0f04a6

    :goto_0
    invoke-virtual {p0, v3}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ")"

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->k:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->k:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const v3, 0x7f0f05b2

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->j:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->k:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->d()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->f()V

    return-void

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 7

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_5

    const v0, 0x7f09039e

    if-eq p1, v0, :cond_1

    const v0, 0x7f0903a1

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->H()V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->h:Lchat/ola/vn/cloud/b;

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->c()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_6

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_6

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->J()Z

    move-result v0

    if-eqz v0, :cond_2

    const v0, 0x7f0f04af

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v0, 0x7f0f0223

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v3, 0x0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v5, ""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v1, v3

    const/4 v3, 0x1

    sget-object v4, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    iget-object v4, v4, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    aput-object v4, v1, v3

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const v0, 0x7f0f04a6

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v0, 0x7f0f0577

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$1;

    invoke-direct {v6, p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$1;-><init>(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;Ljava/util/List;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_2
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_3
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/i;

    invoke-virtual {v1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    invoke-virtual {v1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_4
    const/4 p1, 0x0

    invoke-static {p0, p1, p1, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;)V

    return-void

    :cond_5
    invoke-virtual {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b014b

    invoke-virtual {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->F()V

    return-void
.end method
