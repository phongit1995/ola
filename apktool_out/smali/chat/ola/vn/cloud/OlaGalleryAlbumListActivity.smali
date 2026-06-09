.class public Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;
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

.field private h:Lchat/ola/vn/cloud/a;

.field private i:Landroid/view/View;

.field private j:Landroid/widget/TextView;

.field private k:Ljava/lang/String;

.field private l:Ljava/lang/Runnable;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->g:Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->i:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->j:Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->k:Ljava/lang/String;

    return-void
.end method

.method private E()V
    .locals 2

    const v0, 0x7f09005a

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->g:Landroid/widget/GridView;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->g:Landroid/widget/GridView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a4

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09039e

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->j:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->j:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->j:Landroid/widget/TextView;

    const v1, 0x7f0f04a6

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->j:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->e:Lchat/ola/vn/entity/l;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->e:Lchat/ola/vn/entity/l;

    iget-object v0, v0, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    sput-object v0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

    :cond_0
    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->e:Lchat/ola/vn/entity/l;

    const v1, 0x7f0903a3

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->e:Lchat/ola/vn/entity/l;

    iget-object v0, v0, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0, v1}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->e:Lchat/ola/vn/entity/l;

    iget-object v1, v1, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    invoke-virtual {p0, v1}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f00ee

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    :goto_0
    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->i:Landroid/view/View;

    return-void
.end method

.method private F()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/cloud/a;

    invoke-direct {v0, p0}, Lchat/ola/vn/cloud/a;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {v0, p0}, Lchat/ola/vn/cloud/a;->a(Lchat/ola/vn/cloud/d;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {v0, p0}, Lchat/ola/vn/cloud/a;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->g:Landroid/widget/GridView;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/a;->f()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/a;->f()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/a;->notifyDataSetChanged()V

    return-void

    :cond_2
    :goto_0
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->a_(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;)Lchat/ola/vn/cloud/a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    return-object p0
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/entity/l;)V
    .locals 1

    sput-object p1, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->e:Lchat/ola/vn/entity/l;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;

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

.method static synthetic a(Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->c(Z)V

    return-void
.end method

.method private c(Z)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->l:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity$2;-><init>(Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->l:Ljava/lang/Runnable;

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->l:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->i:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->l:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7530

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->i:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 2

    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

    const-string v1, "null"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public C()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->j:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method public D()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->j:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->F()V

    return-void
.end method

.method public a(Landroid/view/View;Lchat/ola/vn/entity/i;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/l;)V
    .locals 2

    iget-object v0, p1, Lchat/ola/vn/entity/l;->e:Ljava/lang/String;

    const-string v1, "folders"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0, p1}, Lchat/ola/vn/cloud/OlaGalleryPhotoListActivity;->a(Landroid/content/Context;Lchat/ola/vn/entity/l;)V

    return-void

    :cond_0
    invoke-static {p0, p1}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->a(Landroid/content/Context;Lchat/ola/vn/entity/l;)V

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

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->c(Z)V

    sput-object p3, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

    sget-object p1, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "null"

    sput-object p1, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->k:Ljava/lang/String;

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {p1, p2}, Lchat/ola/vn/cloud/a;->a(Ljava/util/List;)V

    return-void
.end method

.method public a(Ljava/util/List;Ljava/lang/String;)V
    .locals 1
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

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->c(Z)V

    sput-object p2, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

    sget-object p2, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    const-string p2, "null"

    sput-object p2, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

    const-string p2, "null"

    iput-object p2, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->k:Ljava/lang/String;

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {p2, p1}, Lchat/ola/vn/cloud/a;->a(Ljava/util/List;)V

    return-void
.end method

.method public a_(I)V
    .locals 2

    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->k:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    if-nez p1, :cond_1

    const/4 p1, 0x1

    :goto_0
    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->c(Z)V

    goto :goto_1

    :cond_1
    const/4 p1, 0x0

    goto :goto_0

    :goto_1
    sget-object p1, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->k:Ljava/lang/String;

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->f:Ljava/lang/String;

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

    return-void
.end method

.method public d(I)V
    .locals 3

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {p1}, Lchat/ola/vn/cloud/a;->e()V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->j:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->j:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->j:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const v2, 0x7f0f04a6

    invoke-virtual {p0, v2}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ")"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/a;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/a;->e()V

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

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039e

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->h:Lchat/ola/vn/cloud/a;

    invoke-virtual {p1}, Lchat/ola/vn/cloud/a;->a()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_2

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_2

    const v0, 0x7f0f04a7

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v0, 0x7f0f0214

    const/4 v1, 0x1

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

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const v0, 0x7f0f04a6

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v0, 0x7f0f0577

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity$1;

    invoke-direct {v6, p0, p1}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity$1;-><init>(Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;Ljava/util/List;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b014b

    invoke-virtual {p0, p1}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaGalleryAlbumListActivity;->E()V

    return-void
.end method
