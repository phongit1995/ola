.class public Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$b;,
        Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;,
        Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;,
        Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;,
        Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;
    }
.end annotation


# static fields
.field private static m:B = 0x0t

.field private static n:Z = true

.field private static o:Z = true

.field private static p:Lchat/ola/vn/view/g$e;


# instance fields
.field private e:Landroid/widget/GridView;

.field private f:Ljava/lang/String;

.field private g:Landroid/view/View;

.field private h:Landroid/view/View;

.field private i:Landroid/widget/TextView;

.field private j:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;

.field private k:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;",
            ">;"
        }
    .end annotation
.end field

.field private l:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->e:Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->f:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->g:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->h:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->i:Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->j:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->k:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    return-void
.end method

.method static synthetic C()Z
    .locals 1

    sget-boolean v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->n:Z

    return v0
.end method

.method static synthetic D()B
    .locals 1

    sget-byte v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->m:B

    return v0
.end method

.method static synthetic E()Lchat/ola/vn/view/g$e;
    .locals 1

    sget-object v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->p:Lchat/ola/vn/view/g$e;

    return-object v0
.end method

.method static synthetic F()Z
    .locals 1

    sget-boolean v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->o:Z

    return v0
.end method

.method private G()V
    .locals 3

    const v0, 0x7f0903cd

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/GridView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->e:Landroid/widget/GridView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->e:Landroid/widget/GridView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->e:Landroid/widget/GridView;

    const/4 v2, 0x3

    invoke-virtual {v0, v2}, Landroid/widget/GridView;->setNumColumns(I)V

    const v0, 0x7f090398

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->i:Landroid/widget/TextView;

    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->h:Landroid/view/View;

    const v0, 0x7f090184

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090463

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-boolean v2, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->n:Z

    if-eqz v2, :cond_0

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_0
    const/16 v1, 0x8

    goto :goto_0

    :goto_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0b00d1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->g:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->g:Landroid/view/View;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    new-instance v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;-><init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->j:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->j:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;

    invoke-virtual {v0, p0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->e:Landroid/widget/GridView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->j:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    sget-byte v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->m:B

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->J()V

    return-void

    :pswitch_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->I()V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private H()V
    .locals 0

    return-void
.end method

.method private I()V
    .locals 5

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->c(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "upload:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x1e

    iget-object v3, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->f:Ljava/lang/String;

    new-instance v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;

    invoke-direct {v4, p0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;-><init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)V

    invoke-static {v4}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;BLjava/lang/String;S)V

    :cond_0
    return-void
.end method

.method private J()V
    .locals 5

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->c(Z)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->k:Ljava/util/List;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    :cond_0
    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    new-instance v3, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;

    invoke-direct {v3, p0, v2}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;-><init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;)V

    new-array v4, v0, [Landroid/content/Context;

    aput-object p0, v4, v1

    invoke-virtual {v3, v4}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    sget-boolean v3, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->o:Z

    if-eqz v3, :cond_1

    :try_start_1
    new-instance v3, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$b;

    invoke-direct {v3, p0, v2}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$b;-><init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;)V

    new-array v0, v0, [Landroid/content/Context;

    aput-object p0, v0, v1

    invoke-virtual {v3, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$b;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->f:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->k:Ljava/util/List;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->k:Ljava/util/List;

    return-object p1
.end method

.method private static a(Landroid/app/Activity;BZLchat/ola/vn/view/g$e;)V
    .locals 0

    sput-byte p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->m:B

    sput-object p3, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->p:Lchat/ola/vn/view/g$e;

    sput-boolean p2, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->n:Z

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 p2, 0x20000

    invoke-virtual {p1, p2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    const p1, 0x7f010036

    const p2, 0x7f01003d

    :try_start_0
    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/app/Activity;ZLchat/ola/vn/view/g$e;)V
    .locals 1

    sput-boolean p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->o:Z

    const/4 p1, 0x0

    const/4 v0, 0x1

    invoke-static {p0, p1, v0, p2}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Landroid/app/Activity;BZLchat/ola/vn/view/g$e;)V

    return-void
.end method

.method private a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    :cond_0
    iget-boolean v0, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->f:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    :cond_2
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->i:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->i:Landroid/widget/TextView;

    const/4 v0, 0x0

    :goto_1
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->i:Landroid/widget/TextView;

    const/16 v0, 0x8

    goto :goto_1

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->c(Z)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->j:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;

    return-object p0
.end method

.method public static b(Landroid/app/Activity;ZLchat/ola/vn/view/g$e;)V
    .locals 0

    sput-boolean p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->o:Z

    const/4 p1, 0x1

    invoke-static {p0, p1, p1, p2}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Landroid/app/Activity;BZLchat/ola/vn/view/g$e;)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->f:Ljava/lang/String;

    return-object p0
.end method

.method private c(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->h:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 2

    sget-byte v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->m:B

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->f:Ljava/lang/String;

    const-string v1, "null"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->H()V

    return-void
.end method

.method public a_(I)V
    .locals 2

    const/4 v0, 0x0

    if-nez p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->h:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->g:Landroid/view/View;

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->h:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->g:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    sget-byte p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->m:B

    if-eqz p1, :cond_1

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->I()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003c

    const v1, 0x7f010037

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    sget-object v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->p:Lchat/ola/vn/view/g$e;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->p:Lchat/ola/vn/view/g$e;

    invoke-interface {v0}, Lchat/ola/vn/view/g$e;->M()V

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 6

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090184

    if-eq p1, v0, :cond_e

    const v0, 0x7f090463

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    if-eqz p1, :cond_f

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-lez p1, :cond_f

    :try_start_1
    sget-byte p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->m:B

    const/4 v0, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-nez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    move-object v3, v2

    :cond_1
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;

    iget-short v5, v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne v5, v1, :cond_3

    if-nez v2, :cond_2

    new-instance v2, Ljava/util/ArrayList;

    iget-object v5, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    invoke-direct {v2, v5}, Ljava/util/ArrayList;-><init>(I)V

    :cond_2
    iget-object v4, v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->d:Ljava/lang/String;

    invoke-interface {v2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    iget-short v5, v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne v5, v0, :cond_1

    if-nez v3, :cond_4

    new-instance v3, Ljava/util/ArrayList;

    iget-object v5, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    invoke-direct {v3, v5}, Ljava/util/ArrayList;-><init>(I)V

    :cond_4
    iget-object v4, v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->d:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_5
    if-eqz v2, :cond_6

    sget-object p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->p:Lchat/ola/vn/view/g$e;

    invoke-interface {p1, v2}, Lchat/ola/vn/view/g$e;->d(Ljava/util/List;)V

    :cond_6
    if-eqz v3, :cond_e

    sget-object p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->p:Lchat/ola/vn/view/g$e;

    invoke-interface {p1, v3}, Lchat/ola/vn/view/g$e;->e(Ljava/util/List;)V

    goto :goto_2

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    move-object v3, v2

    :cond_8
    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_c

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;

    iget-short v5, v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne v5, v1, :cond_a

    if-nez v2, :cond_9

    new-instance v2, Ljava/util/ArrayList;

    iget-object v5, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    invoke-direct {v2, v5}, Ljava/util/ArrayList;-><init>(I)V

    :cond_9
    iget-object v4, v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->e:Ljava/lang/String;

    invoke-interface {v2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_a
    iget-short v5, v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne v5, v0, :cond_8

    if-nez v3, :cond_b

    new-instance v3, Ljava/util/ArrayList;

    iget-object v5, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->l:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    invoke-direct {v3, v5}, Ljava/util/ArrayList;-><init>(I)V

    :cond_b
    iget-object v4, v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->e:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_c
    if-eqz v2, :cond_d

    sget-object p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->p:Lchat/ola/vn/view/g$e;

    invoke-interface {p1, v2}, Lchat/ola/vn/view/g$e;->f(Ljava/util/List;)V

    :cond_d
    if-eqz v3, :cond_e

    sget-object p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->p:Lchat/ola/vn/view/g$e;

    invoke-interface {p1, v3}, Lchat/ola/vn/view/g$e;->g(Ljava/util/List;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_e
    :goto_2
    :try_start_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->finish()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_f
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0135

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->G()V

    return-void
.end method
