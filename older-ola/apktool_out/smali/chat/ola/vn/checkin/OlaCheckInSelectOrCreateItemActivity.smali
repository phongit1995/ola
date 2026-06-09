.class public Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/p/a;


# static fields
.field private static m:Lchat/ola/vn/checkin/b;

.field private static n:Lchat/ola/vn/entity/OlaVenueEntity;

.field private static o:Lchat/ola/vn/entity/OlaCheckInActionEntity;


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Landroid/widget/EditText;

.field private g:Landroid/view/View;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/view/View;

.field private j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;"
        }
    .end annotation
.end field

.field private k:Lchat/ola/vn/checkin/a;

.field private l:I

.field private p:Ljava/lang/Runnable;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->l:I

    return-void
.end method

.method static synthetic C()Lchat/ola/vn/entity/OlaVenueEntity;
    .locals 1

    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->n:Lchat/ola/vn/entity/OlaVenueEntity;

    return-object v0
.end method

.method static synthetic D()Lchat/ola/vn/entity/OlaCheckInActionEntity;
    .locals 1

    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    return-object v0
.end method

.method static synthetic E()Lchat/ola/vn/checkin/b;
    .locals 1

    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->m:Lchat/ola/vn/checkin/b;

    return-object v0
.end method

.method private F()V
    .locals 2

    const v0, 0x7f090319

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->e:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->e:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$1;-><init>(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->e:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$2;-><init>(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    const v0, 0x7f090450

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->f:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->f:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$3;-><init>(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    const v0, 0x7f090453

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$4;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$4;-><init>(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->f:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$5;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$5;-><init>(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->f:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$6;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$6;-><init>(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    const v0, 0x7f0905d7

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->g:Landroid/view/View;

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->h:Landroid/widget/TextView;

    const v0, 0x7f09039e

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f04f5

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09030e

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->i:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private G()V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/checkin/a;

    invoke-direct {v0, p0}, Lchat/ola/vn/checkin/a;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->k:Lchat/ola/vn/checkin/a;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->k:Lchat/ola/vn/checkin/a;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->k:Lchat/ola/vn/checkin/a;

    invoke-virtual {v0, p0}, Lchat/ola/vn/checkin/a;->a(Lchat/ola/vn/b/j$a;)V

    const-string v0, ""

    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->g(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->j:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->k:Lchat/ola/vn/checkin/a;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->j:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/checkin/a;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->k:Lchat/ola/vn/checkin/a;

    invoke-virtual {v0}, Lchat/ola/vn/checkin/a;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)Lchat/ola/vn/checkin/a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->k:Lchat/ola/vn/checkin/a;

    return-object p0
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/entity/OlaVenueEntity;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/checkin/b;)V
    .locals 0

    sput-object p2, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    sput-object p1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->n:Lchat/ola/vn/entity/OlaVenueEntity;

    sput-object p3, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->m:Lchat/ola/vn/checkin/b;

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 p2, 0x20000

    invoke-virtual {p1, p2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

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

.method static synthetic a(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->h(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;Ljava/lang/String;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->a(Ljava/lang/String;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->c(Z)V

    return-void
.end method

.method private a(Ljava/lang/String;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 4

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->c(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p3}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->a()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$8;

    invoke-direct {v3, p0, p2, p3}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$8;-><init>(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    invoke-virtual {v0, v1, p1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/a;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->f:Landroid/widget/EditText;

    return-object p0
.end method

.method private c(Z)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->p:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$7;

    invoke-direct {v0, p0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$7;-><init>(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)V

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->p:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->p:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->i:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->p:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7530

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->i:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method private g(Ljava/lang/String;)V
    .locals 3

    const/4 v0, 0x1

    :try_start_0
    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->c(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a()Ljava/lang/String;

    move-result-object v1

    iget v2, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->l:I

    invoke-virtual {v0, p1, v1, v2, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;ILchat/ola/vn/p/a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method private h(Ljava/lang/String;)V
    .locals 3

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->i(Ljava/lang/String;)Lchat/ola/vn/entity/OlaCheckInItemEntity;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object p1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->n:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object p1

    sget-object v1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-direct {p0, p1, v1, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->a(Ljava/lang/String;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    return-void

    :cond_0
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->c(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    sget-object v2, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v2}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2, p0}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/a;)V

    return-void
.end method

.method private i(Ljava/lang/String;)Lchat/ola/vn/entity/OlaCheckInItemEntity;
    .locals 4

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->k:Lchat/ola/vn/checkin/a;

    invoke-virtual {v2}, Lchat/ola/vn/checkin/a;->getCount()I

    move-result v2

    if-ge v1, v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->k:Lchat/ola/vn/checkin/a;

    invoke-virtual {v2, v1}, Lchat/ola/vn/checkin/a;->a(I)Lchat/ola/vn/entity/OlaCheckInItemEntity;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_1

    return-object v2

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    :cond_2
    return-object v0
.end method


# virtual methods
.method public B()Z
    .locals 1

    iget v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->l:I

    if-lez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 2

    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->n:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-direct {p0, v0, v1, p1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->a(Ljava/lang/String;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

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

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->c(Z)V

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

    const/4 p2, 0x0

    const/4 v0, 0x2

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iput p2, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->l:I

    :goto_0
    invoke-direct {p0, p2}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->c(Z)V

    return-void
.end method

.method public a_(I)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->g(Ljava/lang/String;)V

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
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;I)V"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->c(Z)V

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->j:Ljava/util/List;

    if-nez v1, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->j:Ljava/util/List;

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/OlaCheckInItemEntity;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->j:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->k:Lchat/ola/vn/checkin/a;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->j:Ljava/util/List;

    invoke-virtual {p1, v0}, Lchat/ola/vn/checkin/a;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->k:Lchat/ola/vn/checkin/a;

    invoke-virtual {p1}, Lchat/ola/vn/checkin/a;->notifyDataSetChanged()V

    iput p2, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->l:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
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
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
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
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->h(Ljava/lang/String;)V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->finish()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b004f

    invoke-virtual {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->F()V

    :try_start_0
    sget-object p1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    if-eqz p1, :cond_2

    sget-object p1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->d()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->f:Landroid/widget/EditText;

    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->d()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->h:Landroid/widget/TextView;

    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->d()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :cond_0
    :try_start_1
    sget-object p1, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->e()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->g:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->g:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    :try_start_2
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    new-instance p1, Ljava/util/ArrayList;

    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->o:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->f()Ljava/util/List;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->j:Ljava/util/List;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_2
    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->G()V

    return-void
.end method
