.class public Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/p/a;


# static fields
.field private static k:Lchat/ola/vn/entity/OlaVenueEntity;

.field private static l:Lchat/ola/vn/checkin/b;


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Lchat/ola/vn/b/c;

.field private g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInActionEntity;",
            ">;"
        }
    .end annotation
.end field

.field private h:Landroid/view/View;

.field private i:Landroid/widget/EditText;

.field private j:Lchat/ola/vn/entity/OlaCheckInActionEntity;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method static synthetic B()Lchat/ola/vn/checkin/b;
    .locals 1

    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->l:Lchat/ola/vn/checkin/b;

    return-object v0
.end method

.method static synthetic C()Lchat/ola/vn/entity/OlaVenueEntity;
    .locals 1

    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->k:Lchat/ola/vn/entity/OlaVenueEntity;

    return-object v0
.end method

.method private D()V
    .locals 2

    const v0, 0x7f090316

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->e:Landroid/widget/ListView;

    const v0, 0x7f09030e

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->h:Landroid/view/View;

    const v0, 0x7f090450

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->i:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->i:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$1;-><init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    const v0, 0x7f090453

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$2;-><init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->i:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$3;-><init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->i:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$4;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$4;-><init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f06b5

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f09039e

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f04f5

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->e:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$5;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$5;-><init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->e:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$6;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$6;-><init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private E()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->i:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    iget-object v2, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->f:Lchat/ola/vn/b/c;

    invoke-virtual {v2}, Lchat/ola/vn/b/c;->getCount()I

    move-result v2

    :goto_0
    if-ge v1, v2, :cond_1

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->f:Lchat/ola/vn/b/c;

    invoke-virtual {v3, v1}, Lchat/ola/vn/b/c;->a(I)Lchat/ola/vn/entity/OlaCheckInActionEntity;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-direct {p0, v3}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Lchat/ola/vn/entity/OlaCheckInActionEntity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    return-void
.end method

.method private F()V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/b/c;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->f:Lchat/ola/vn/b/c;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->c(Z)V

    const-string v0, ""

    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->g(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->f:Lchat/ola/vn/b/c;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->i:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;Lchat/ola/vn/entity/OlaCheckInActionEntity;)Lchat/ola/vn/entity/OlaCheckInActionEntity;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->j:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    return-object p1
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/entity/OlaVenueEntity;Lchat/ola/vn/checkin/b;)V
    .locals 0

    :try_start_0
    sput-object p1, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->k:Lchat/ola/vn/entity/OlaVenueEntity;

    sput-object p2, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->l:Lchat/ola/vn/checkin/b;

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 p2, 0x20000

    invoke-virtual {p1, p2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const p2, 0x7f010039

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->c(Z)V

    return-void
.end method

.method private a(Lchat/ola/vn/entity/OlaCheckInActionEntity;)V
    .locals 2

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->e()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->f()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->f()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->k:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, p1, v1}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Ljava/lang/String;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->finish()V

    return-void

    :cond_1
    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->k:Lchat/ola/vn/entity/OlaVenueEntity;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$7;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$7;-><init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V

    invoke-static {p0, v0, p1, v1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->a(Landroid/content/Context;Lchat/ola/vn/entity/OlaVenueEntity;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/checkin/b;)V

    return-void
.end method

.method private a(Ljava/lang/String;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 3

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->c(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$8;

    invoke-direct {v2, p0, p2, p3}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$8;-><init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    const/4 p2, 0x0

    invoke-virtual {v0, v1, p1, p2, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/a;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)Lchat/ola/vn/b/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->f:Lchat/ola/vn/b/c;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;Lchat/ola/vn/entity/OlaCheckInActionEntity;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Lchat/ola/vn/entity/OlaCheckInActionEntity;)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->E()V

    return-void
.end method

.method private c(Z)V
    .locals 3

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->h:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->h:Landroid/view/View;

    new-instance v0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$9;

    invoke-direct {v0, p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$9;-><init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V

    const-wide/16 v1, 0x7530

    invoke-virtual {p1, v0, v1, v2}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->h:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)Lchat/ola/vn/entity/OlaCheckInActionEntity;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->j:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    return-object p0
.end method

.method private g(Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/a;)V

    :cond_0
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
    .locals 0

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
    .locals 0

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->c(Z)V

    return-void
.end method

.method public b(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

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
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInActionEntity;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->g:Ljava/util/List;

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->f:Lchat/ola/vn/b/c;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->g:Ljava/util/List;

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/c;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->f:Lchat/ola/vn/b/c;

    invoke-virtual {p1}, Lchat/ola/vn/b/c;->notifyDataSetChanged()V

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->c(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
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

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/c;->onActivityResult(IILandroid/content/Intent;)V

    const/4 p1, -0x1

    if-ne p2, p1, :cond_1

    if-eqz p3, :cond_1

    :try_start_0
    const-string p2, "extra_back_action"

    const/4 v0, 0x0

    invoke-virtual {p3, p2, v0}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result p2

    if-eqz p2, :cond_0

    const-string p1, "extra_check_in_action"

    invoke-virtual {p3, p1}, Landroid/content/Intent;->getSerializableExtra(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/OlaCheckInActionEntity;

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->j:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->f:Lchat/ola/vn/b/c;

    invoke-virtual {p1}, Lchat/ola/vn/b/c;->getFilter()Landroid/widget/Filter;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->j:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {p2}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/Filter;->filter(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->i:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->j:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {p2}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->i:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->j:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {p2}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p2

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setSelection(I)V

    return-void

    :cond_0
    invoke-virtual {p0, p1, p3}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039e

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->k:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Ljava/lang/String;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->finish()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b004d

    invoke-virtual {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->D()V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->F()V

    return-void
.end method
