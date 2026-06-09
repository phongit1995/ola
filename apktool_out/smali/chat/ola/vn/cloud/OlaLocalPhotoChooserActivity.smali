.class public Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/cloud/d;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;,
        Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$a;,
        Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;
    }
.end annotation


# static fields
.field private static e:Lchat/ola/vn/view/g$e;


# instance fields
.field private f:Landroid/widget/GridView;

.field private g:Lchat/ola/vn/cloud/b;

.field private h:Landroid/view/View;

.field private i:Landroid/view/View;

.field private j:Landroid/widget/TextView;

.field private k:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;"
        }
    .end annotation
.end field

.field private l:Lchat/ola/vn/entity/l;

.field private m:Ljava/io/File;

.field private n:Landroid/widget/ListView;

.field private o:Lchat/ola/vn/b/a;

.field private p:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->f:Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->h:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->i:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->j:Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->k:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->m:Ljava/io/File;

    return-void
.end method

.method private E()V
    .locals 2

    const v0, 0x7f09005a

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->f:Landroid/widget/GridView;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->f:Landroid/widget/GridView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f0903a4

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09039e

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090144

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->h:Landroid/view/View;

    const v0, 0x7f0901da

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->i:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->i:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090058

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    new-instance v0, Lchat/ola/vn/b/a;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/a;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->o:Lchat/ola/vn/b/a;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->o:Lchat/ola/vn/b/a;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$1;-><init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    return-void
.end method

.method private F()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/cloud/b;

    invoke-direct {v0, p0}, Lchat/ola/vn/cloud/b;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->e()V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0, p0}, Lchat/ola/vn/cloud/b;->a(Lchat/ola/vn/cloud/d;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0, p0}, Lchat/ola/vn/cloud/b;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->f:Landroid/widget/GridView;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->g()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->g()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0}, Lchat/ola/vn/cloud/b;->notifyDataSetChanged()V

    return-void

    :cond_2
    :goto_0
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->d(Z)V

    new-instance v1, Lchat/ola/vn/entity/l;

    invoke-direct {v1}, Lchat/ola/vn/entity/l;-><init>()V

    iput-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    const v2, 0x7f0f041d

    invoke-virtual {p0, v2}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->k:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->k:Ljava/util/List;

    iget-object v2, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    iput-boolean v0, v1, Lchat/ola/vn/entity/l;->k:Z

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->j:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    iget-object v1, v1, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->o:Lchat/ola/vn/b/a;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->k:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/a;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->o:Lchat/ola/vn/b/a;

    invoke-virtual {v0}, Lchat/ola/vn/b/a;->notifyDataSetChanged()V

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->I()V

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->J()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private G()V
    .locals 3

    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    const-string v0, "android.permission.CAMERA"

    invoke-virtual {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "android.permission.CAMERA"

    aput-object v2, v0, v1

    const/16 v1, 0x69

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->H()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private H()V
    .locals 4

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.media.action.IMAGE_CAPTURE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/io/File;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Lchat/ola/vn/d;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->m:Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->m:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->m:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    :cond_0
    const-string v1, "output"

    iget-object v2, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->m:Ljava/io/File;

    invoke-static {v2}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const/4 v1, 0x2

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private I()V
    .locals 3

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->d(Z)V

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->o:Lchat/ola/vn/b/a;

    invoke-virtual {v1}, Lchat/ola/vn/b/a;->a()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-interface {v1}, Ljava/util/List;->clear()V

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->o:Lchat/ola/vn/b/a;

    invoke-virtual {v1}, Lchat/ola/vn/b/a;->notifyDataSetChanged()V

    :cond_0
    :try_start_0
    new-instance v1, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;-><init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$1;)V

    new-array v0, v0, [Landroid/content/Context;

    const/4 v2, 0x0

    aput-object p0, v0, v2

    invoke-virtual {v1, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private J()V
    .locals 3

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->d(Z)V

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v1}, Lchat/ola/vn/cloud/b;->g()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-interface {v1}, Ljava/util/List;->clear()V

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v1}, Lchat/ola/vn/cloud/b;->notifyDataSetChanged()V

    :cond_0
    :try_start_0
    new-instance v1, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$a;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$a;-><init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$1;)V

    new-array v0, v0, [Landroid/content/Context;

    const/4 v2, 0x0

    aput-object p0, v0, v2

    invoke-virtual {v1, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$a;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/b/a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->o:Lchat/ola/vn/b/a;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;Lchat/ola/vn/entity/l;)Lchat/ola/vn/entity/l;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->k:Ljava/util/List;

    return-object p1
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/view/g$e;)V
    .locals 1

    sput-object p1, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->e:Lchat/ola/vn/view/g$e;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

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

.method static synthetic a(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->c(Z)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Landroid/widget/GridView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->f:Landroid/widget/GridView;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->d(Z)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/entity/l;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    return-object p0
.end method

.method private c(Z)V
    .locals 2

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getVisibility()I

    move-result p1

    if-nez p1, :cond_1

    const p1, 0x7f010012

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    invoke-virtual {v0, p1}, Landroid/widget/ListView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->h:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    const p1, 0x7f010020

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    invoke-virtual {v0, p1}, Landroid/widget/ListView;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_1
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/cloud/b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    return-object p0
.end method

.method private d(Z)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->p:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$2;-><init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->p:Ljava/lang/Runnable;

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->p:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->h:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->p:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7530

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->h:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    return-void
.end method

.method static synthetic e(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->j:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic f(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->k:Ljava/util/List;

    return-object p0
.end method


# virtual methods
.method public B()Z
    .locals 1

    const/4 v0, 0x0

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

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->F()V

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

.method public a(Ljava/util/List;Ljava/lang/String;S)V
    .locals 0
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

    return-void
.end method

.method public a_(I)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    const/4 v0, 0x0

    if-nez p1, :cond_0

    invoke-direct {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->d(Z)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    iget-object p1, p1, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    if-nez p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->J()V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    iget-object p1, p1, Lchat/ola/vn/entity/l;->l:Ljava/util/List;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    iget-object p1, p1, Lchat/ola/vn/entity/l;->l:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->g()Ljava/util/List;

    move-result-object p1

    if-nez p1, :cond_2

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    const/4 v0, 0x1

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->l:Lchat/ola/vn/entity/l;

    iget-object v1, v1, Lchat/ola/vn/entity/l;->l:Ljava/util/List;

    invoke-interface {p1, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    new-instance v1, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$3;-><init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)V

    invoke-static {p1, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {v0, p1}, Lchat/ola/vn/cloud/b;->b(Ljava/util/List;)V

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->notifyDataSetChanged()V

    :cond_4
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
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    const/4 p3, 0x2

    if-ne p1, p3, :cond_0

    const/4 p1, -0x1

    if-ne p2, p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->m:Ljava/io/File;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->m:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_0

    new-instance p1, Ljava/io/File;

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->m:Ljava/io/File;

    invoke-virtual {p2}, Ljava/io/File;->length()J

    move-result-wide p2

    invoke-static {p2, p3}, Lchat/ola/vn/d;->a(J)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->m:Ljava/io/File;

    const/4 p3, 0x1

    invoke-static {p2, p1, p3}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;Ljava/io/File;Z)V

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->m:Ljava/io/File;

    invoke-virtual {p2}, Ljava/io/File;->delete()Z

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2, p3}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-object p1, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->e:Lchat/ola/vn/view/g$e;

    invoke-interface {p1, p2}, Lchat/ola/vn/view/g$e;->f(Ljava/util/List;)V

    invoke-virtual {p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->m:Ljava/io/File;

    return-void
.end method

.method public onBackPressed()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    invoke-virtual {v0}, Landroid/widget/ListView;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->c(Z)V

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
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->n:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getVisibility()I

    move-result p1

    if-nez p1, :cond_2

    :cond_1
    invoke-direct {p0, v1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->c(Z)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->k:Ljava/util/List;

    if-eqz p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->k:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_a

    invoke-direct {p0, v2}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->c(Z)V

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->g:Lchat/ola/vn/cloud/b;

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

    invoke-virtual {v5}, Lchat/ola/vn/entity/i;->m()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_4
    invoke-virtual {v5}, Lchat/ola/vn/entity/i;->f()S

    move-result v6

    const/4 v7, 0x2

    if-ne v6, v7, :cond_5

    invoke-virtual {v5}, Lchat/ola/vn/entity/i;->m()Ljava/lang/String;

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

    sget-object p1, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->e:Lchat/ola/vn/view/g$e;

    invoke-interface {p1, v0}, Lchat/ola/vn/view/g$e;->f(Ljava/util/List;)V

    :cond_7
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_8

    sget-object p1, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->e:Lchat/ola/vn/view/g$e;

    invoke-interface {p1, v3}, Lchat/ola/vn/view/g$e;->g(Ljava/util/List;)V

    :cond_8
    invoke-virtual {p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->finish()V

    return-void

    :cond_9
    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->G()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_a
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b014d

    invoke-virtual {p0, p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->E()V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 0

    const/16 p2, 0x69

    if-ne p1, p2, :cond_0

    const/4 p1, 0x0

    aget p1, p3, p1

    if-nez p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->H()V

    :cond_0
    return-void
.end method
