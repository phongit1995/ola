.class public Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/p/a;


# static fields
.field private static l:Lchat/ola/vn/checkin/b;

.field private static m:Ljava/lang/String;


# instance fields
.field e:Lchat/ola/vn/entity/OlaVenueEntity;

.field private f:Landroid/widget/EditText;

.field private g:Landroid/widget/EditText;

.field private h:Landroid/widget/EditText;

.field private i:Landroid/view/View;

.field private j:Landroid/view/View;

.field private k:Landroid/view/animation/Animation;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method static synthetic B()Lchat/ola/vn/checkin/b;
    .locals 1

    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->l:Lchat/ola/vn/checkin/b;

    return-object v0
.end method

.method private C()V
    .locals 2

    const v0, 0x7f010042

    :try_start_0
    invoke-static {p0, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->k:Landroid/view/animation/Animation;

    const v0, 0x7f0905ab

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->f:Landroid/widget/EditText;

    const v0, 0x7f0905a9

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->g:Landroid/widget/EditText;

    const v0, 0x7f0905aa

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->h:Landroid/widget/EditText;

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f049e

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0900c4

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->i:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->i:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09030e

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->j:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private D()V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->g:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->h:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->f:Landroid/widget/EditText;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->k:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->c(Z)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->e:Lchat/ola/vn/entity/OlaVenueEntity;

    if-nez v0, :cond_1

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v3, 0x0

    move-object v6, p0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/a;)V

    return-void

    :cond_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->e:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v2

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->e:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->c()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->e:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->d()Ljava/lang/String;

    move-result-object v5

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->e:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->e()Ljava/lang/String;

    move-result-object v6

    move-object v7, p0

    invoke-virtual/range {v1 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method

.method private E()V
    .locals 8

    :try_start_0
    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->m:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->f:Landroid/widget/EditText;

    sget-object v1, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->m:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->f:Landroid/widget/EditText;

    sget-object v1, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->m:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V

    :cond_0
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v2

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v4

    const/4 v6, 0x1

    new-instance v7, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$2;

    invoke-direct {v7, p0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$2;-><init>(Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;)V

    move-object v1, p0

    invoke-static/range {v1 .. v7}, Lchat/ola/vn/n/b;->a(Landroid/content/Context;DDILchat/ola/vn/n/b$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->g:Landroid/widget/EditText;

    return-object p0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/checkin/b;)V
    .locals 0

    :try_start_0
    sput-object p2, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->l:Lchat/ola/vn/checkin/b;

    sput-object p1, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->m:Ljava/lang/String;

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 p2, 0x20000

    invoke-virtual {p1, p2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const p2, 0x7f010039

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->c(Z)V

    return-void
.end method

.method private c(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$3;-><init>(Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;)V

    invoke-static {p0, p1, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Landroid/content/Context;Lchat/ola/vn/entity/OlaVenueEntity;Lchat/ola/vn/checkin/b;)V

    return-void
.end method

.method private c(Z)V
    .locals 3

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->j:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->j:Landroid/view/View;

    new-instance v0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$1;-><init>(Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;)V

    const-wide/16 v1, 0x7530

    invoke-virtual {p1, v0, v1, v2}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->j:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 1

    const/4 v0, 0x0

    :try_start_0
    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->c(Z)V

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->e:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->c(Lchat/ola/vn/entity/OlaVenueEntity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/o;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/y;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/util/List;J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;J)V"
        }
    .end annotation

    return-void
.end method

.method public a(SLjava/lang/String;)V
    .locals 1

    const/4 v0, 0x3

    if-eq p1, v0, :cond_0

    const/4 v0, 0x7

    :cond_0
    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->c(Z)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    const/4 p1, 0x0

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    :cond_1
    return-void
.end method

.method public b(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 1

    const/4 v0, 0x0

    :try_start_0
    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->c(Z)V

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->e:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->c(Lchat/ola/vn/entity/OlaVenueEntity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public b(Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;I)V"
        }
    .end annotation

    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInActionEntity;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public c(Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;I)V"
        }
    .end annotation

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    const/4 p1, 0x0

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->c(Z)V

    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900c4

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->finish()V

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->D()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0048

    invoke-virtual {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->C()V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->E()V

    return-void
.end method
