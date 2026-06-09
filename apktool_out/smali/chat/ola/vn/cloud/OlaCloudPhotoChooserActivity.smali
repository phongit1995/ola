.class public Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/cloud/d;


# static fields
.field private static e:Lchat/ola/vn/view/g$e;


# instance fields
.field private f:Landroid/widget/GridView;

.field private g:Lchat/ola/vn/cloud/b;

.field private h:Landroid/view/View;

.field private i:Landroid/view/View;

.field private j:Landroid/widget/TextView;

.field private k:Ljava/lang/String;

.field private l:Ljava/lang/String;

.field private m:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;"
        }
    .end annotation
.end field

.field private n:Lchat/ola/vn/entity/l;

.field private o:Landroid/widget/ListView;

.field private p:Lchat/ola/vn/b/a;

.field private q:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->f:Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->h:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->i:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->j:Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->k:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->l:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->m:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->n:Lchat/ola/vn/entity/l;

    return-void
.end method

.method private E()V
    .locals 2

    const v0, 0x7f09005a

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->f:Landroid/widget/GridView;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->f:Landroid/widget/GridView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    const v0, 0x7f090144

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f0903a4

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09039e

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->h:Landroid/view/View;

    const v0, 0x7f0901da

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->i:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->i:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090058

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    new-instance v0, Lchat/ola/vn/b/a;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/a;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->p:Lchat/ola/vn/b/a;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->p:Lchat/ola/vn/b/a;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;-><init>(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    return-void
.end method

.method private F()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/cloud/b;

    invoke-direct {v0, p0}, Lchat/ola/vn/cloud/b;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->e()V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0, p0}, Lchat/ola/vn/cloud/b;->a(Lchat/ola/vn/cloud/d;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0, p0}, Lchat/ola/vn/cloud/b;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->f:Landroid/widget/GridView;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->g()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->g()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->notifyDataSetChanged()V

    return-void

    :cond_2
    :goto_0
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->d(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->e(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Lchat/ola/vn/b/a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->p:Lchat/ola/vn/b/a;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;Lchat/ola/vn/entity/l;)Lchat/ola/vn/entity/l;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->n:Lchat/ola/vn/entity/l;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->k:Ljava/lang/String;

    return-object p1
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/view/g$e;)V
    .locals 1

    sput-object p1, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->e:Lchat/ola/vn/view/g$e;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010036

    const v0, 0x7f01003d

    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->c(Z)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Lchat/ola/vn/entity/l;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->n:Lchat/ola/vn/entity/l;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->d(Z)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Lchat/ola/vn/cloud/b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    return-object p0
.end method

.method private c(Z)V
    .locals 2

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getVisibility()I

    move-result p1

    if-nez p1, :cond_1

    const p1, 0x7f010012

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    invoke-virtual {v0, p1}, Landroid/widget/ListView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->h:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    const p1, 0x7f010020

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    invoke-virtual {v0, p1}, Landroid/widget/ListView;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_1
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->j:Landroid/widget/TextView;

    return-object p0
.end method

.method private d(Z)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->q:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$2;-><init>(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->q:Ljava/lang/Runnable;

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->q:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->h:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->q:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7530

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->h:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    return-void
.end method


# virtual methods
.method public B()Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->k:Ljava/lang/String;

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
    .locals 0

    return-void
.end method

.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->F()V

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->d(Z)V

    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->k:Ljava/lang/String;

    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->l:Ljava/lang/String;

    return-void
.end method

.method public a(Landroid/view/View;Lchat/ola/vn/entity/i;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/l;)V
    .locals 0

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
    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->d(Z)V

    iput-object p3, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->k:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    if-eqz p2, :cond_0

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p1

    if-nez p1, :cond_1

    :cond_0
    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->k:Ljava/lang/String;

    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->l:Ljava/lang/String;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {p1, p2}, Lchat/ola/vn/cloud/b;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(Ljava/util/List;Ljava/lang/String;S)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->m:Ljava/util/List;

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->m:Ljava/util/List;

    const/4 p3, 0x0

    invoke-interface {p2, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entity/l;

    iput-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->n:Lchat/ola/vn/entity/l;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/l;

    iget-object v1, v0, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "upload:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->n:Lchat/ola/vn/entity/l;

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->n:Lchat/ola/vn/entity/l;

    const/4 v0, 0x1

    iput-boolean v0, p2, Lchat/ola/vn/entity/l;->k:Z

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->j:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->n:Lchat/ola/vn/entity/l;

    iget-object v0, v0, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->p:Lchat/ola/vn/b/a;

    invoke-virtual {p2, p1}, Lchat/ola/vn/b/a;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->p:Lchat/ola/vn/b/a;

    invoke-virtual {p1}, Lchat/ola/vn/b/a;->notifyDataSetChanged()V

    invoke-virtual {p0, p3}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->a_(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a_(I)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->k:Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->k:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->l:Ljava/lang/String;

    invoke-static {v0, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->d(Z)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->n:Lchat/ola/vn/entity/l;

    if-nez v0, :cond_1

    invoke-direct {p0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->d(Z)V

    return-void

    :cond_1
    if-nez p1, :cond_2

    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->d(Z)V

    goto :goto_0

    :cond_2
    invoke-direct {p0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->d(Z)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->k:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->l:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->k:Ljava/lang/String;

    const-string v0, "null"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    return-void

    :cond_3
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->n:Lchat/ola/vn/entity/l;

    iget-object v0, v0, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    const/16 v2, 0x32

    iget-object v3, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->k:Ljava/lang/String;

    invoke-virtual {p1, v0, v2, v3, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;BLjava/lang/String;S)V

    return-void
.end method

.method public d(I)V
    .locals 0

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003c

    const v1, 0x7f010037

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    invoke-virtual {v0}, Landroid/widget/ListView;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->c(Z)V

    return-void

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 8

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090144

    if-eq p1, v0, :cond_9

    const v0, 0x7f0901da

    const/4 v1, 0x0

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039e

    const/4 v2, 0x1

    if-eq p1, v0, :cond_3

    const v0, 0x7f0903a4

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->o:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getVisibility()I

    move-result p1

    if-nez p1, :cond_2

    :cond_1
    invoke-direct {p0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->c(Z)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->m:Ljava/util/List;

    if-eqz p1, :cond_9

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->m:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_9

    invoke-direct {p0, v2}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->c(Z)V

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->c()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_8

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_8

    new-instance v0, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    invoke-direct {v0, v3}, Ljava/util/ArrayList;-><init>(I)V

    new-instance v3, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v4

    invoke-direct {v3, v4}, Ljava/util/ArrayList;-><init>(I)V

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v4

    :goto_0
    if-ge v1, v4, :cond_6

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/entity/i;

    invoke-virtual {v5}, Lchat/ola/vn/entity/i;->f()S

    move-result v6

    if-ne v6, v2, :cond_4

    invoke-virtual {v5}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_4
    invoke-virtual {v5}, Lchat/ola/vn/entity/i;->f()S

    move-result v6

    const/4 v7, 0x2

    if-ne v6, v7, :cond_5

    invoke-virtual {v5}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_5
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_6
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_7

    sget-object p1, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->e:Lchat/ola/vn/view/g$e;

    invoke-interface {p1, v0}, Lchat/ola/vn/view/g$e;->d(Ljava/util/List;)V

    :cond_7
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_8

    sget-object p1, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->e:Lchat/ola/vn/view/g$e;

    invoke-interface {p1, v3}, Lchat/ola/vn/view/g$e;->e(Ljava/util/List;)V

    :cond_8
    invoke-virtual {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_9
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b014d

    invoke-virtual {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->E()V

    return-void
.end method
