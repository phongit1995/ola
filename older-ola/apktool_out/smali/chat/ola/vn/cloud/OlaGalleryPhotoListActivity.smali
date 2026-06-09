.class public Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/cloud/d;
.implements Lchat/ola/vn/p/n;


# static fields
.field private static e:Lchat/ola/vn/entity/l;


# instance fields
.field private f:Landroid/widget/GridView;

.field private g:Lchat/ola/vn/cloud/c;

.field private h:Landroid/view/View;

.field private i:Ljava/lang/String;

.field private j:Ljava/lang/String;

.field private k:Ljava/lang/Runnable;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->f:Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->g:Lchat/ola/vn/cloud/c;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->h:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->i:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->j:Ljava/lang/String;

    return-void
.end method

.method private E()V
    .locals 2

    const v0, 0x7f09005a

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->f:Landroid/widget/GridView;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->f:Landroid/widget/GridView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a4

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    const v1, 0x7f0903a3

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    iget-object v0, v0, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0, v1}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    iget-object v1, v1, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v1}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f00ee

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    :goto_0
    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->h:Landroid/view/View;

    return-void
.end method

.method private F()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->g:Lchat/ola/vn/cloud/c;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/cloud/c;

    invoke-direct {v0, p0}, Lchat/ola/vn/cloud/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->g:Lchat/ola/vn/cloud/c;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->g:Lchat/ola/vn/cloud/c;

    invoke-virtual {v0, p0}, Lchat/ola/vn/cloud/c;->a(Lchat/ola/vn/cloud/d;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->g:Lchat/ola/vn/cloud/c;

    invoke-virtual {v0, p0}, Lchat/ola/vn/cloud/c;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->f:Landroid/widget/GridView;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->g:Lchat/ola/vn/cloud/c;

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->g:Lchat/ola/vn/cloud/c;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/c;->a()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->g:Lchat/ola/vn/cloud/c;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/c;->a()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->g:Lchat/ola/vn/cloud/c;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/c;->notifyDataSetChanged()V

    return-void

    :cond_2
    :goto_0
    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    if-eqz v0, :cond_3

    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    iget-object v0, v0, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->i:Ljava/lang/String;

    :cond_3
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->a_(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/entity/l;)V
    .locals 1

    sput-object p1, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->e:Lchat/ola/vn/entity/l;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const v0, 0x7f010039

    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->c(Z)V

    return-void
.end method

.method private c(Z)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->k:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity$1;-><init>(Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->k:Ljava/lang/Runnable;

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->k:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->h:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->k:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7530

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->h:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->i:Ljava/lang/String;

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

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->F()V

    return-void
.end method

.method public a(Landroid/view/View;Lchat/ola/vn/entity/i;)V
    .locals 8

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->g:Lchat/ola/vn/cloud/c;

    invoke-virtual {v1}, Lchat/ola/vn/cloud/c;->a()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/i;

    new-instance v4, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/i;->h()Ljava/lang/String;

    move-result-object v3

    sget v5, Lchat/ola/vn/e;->c:I

    sget v6, Lchat/ola/vn/e;->d:I

    invoke-static {v5, v6}, Ljava/lang/Math;->max(II)I

    move-result v5

    sget v6, Lchat/ola/vn/e;->c:I

    sget v7, Lchat/ola/vn/e;->d:I

    invoke-static {v6, v7}, Ljava/lang/Math;->max(II)I

    move-result v6

    invoke-static {v3, v5, v6}, Lchat/ola/vn/entity/l;->a(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v3

    const/4 v5, 0x3

    const/4 v6, 0x1

    invoke-direct {v4, v3, v5, v6}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    invoke-interface {v1, p2}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result p2

    invoke-static {p0, p1, v2, p2, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/entity/l;)V
    .locals 2

    iget-short v0, p1, Lchat/ola/vn/entity/l;->i:S

    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    invoke-static {p0, p1}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->a(Landroid/content/Context;Lchat/ola/vn/entity/l;)V

    :cond_0
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
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->i:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->i:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->j:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    if-nez p1, :cond_1

    const/4 p1, 0x1

    :goto_0
    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->c(Z)V

    goto :goto_1

    :cond_1
    const/4 p1, 0x0

    goto :goto_0

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->i:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->j:Ljava/lang/String;

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->i:Ljava/lang/String;

    invoke-virtual {p1, v0, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/n;)V

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

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->c(Z)V

    iput-object p3, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->i:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->g:Lchat/ola/vn/cloud/c;

    invoke-virtual {p1, p2}, Lchat/ola/vn/cloud/c;->a(Ljava/util/List;)V

    return-void
.end method

.method public d(I)V
    .locals 0

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b014b

    invoke-virtual {p0, p1}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->E()V

    return-void
.end method
