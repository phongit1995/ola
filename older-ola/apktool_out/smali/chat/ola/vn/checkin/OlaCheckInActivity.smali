.class public Lchat/ola/vn/checkin/OlaCheckInActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/b/p$a;
.implements Lchat/ola/vn/p/a;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/c;",
        "Landroid/view/View$OnClickListener;",
        "Lchat/ola/vn/b/j$a;",
        "Lchat/ola/vn/b/p$a<",
        "Lchat/ola/vn/entity/OlaVenueEntity;",
        ">;",
        "Lchat/ola/vn/p/a;"
    }
.end annotation


# static fields
.field private static p:Lchat/ola/vn/checkin/b;


# instance fields
.field private e:Landroid/widget/EditText;

.field private f:Landroid/widget/ListView;

.field private g:Landroid/view/View;

.field private h:Landroid/view/View;

.field private i:Landroid/widget/TextView;

.field private j:Lchat/ola/vn/b/p;

.field private k:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;"
        }
    .end annotation
.end field

.field private l:I

.field private m:Lchat/ola/vn/entity/OlaVenueEntity;

.field private n:Lchat/ola/vn/entity/OlaCheckInItemEntity;

.field private o:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->l:I

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->m:Lchat/ola/vn/entity/OlaVenueEntity;

    iput-boolean v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->o:Z

    return-void
.end method

.method static synthetic C()Lchat/ola/vn/checkin/b;
    .locals 1

    sget-object v0, Lchat/ola/vn/checkin/OlaCheckInActivity;->p:Lchat/ola/vn/checkin/b;

    return-object v0
.end method

.method private D()V
    .locals 3

    const v0, 0x7f090450

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->e:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->e:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInActivity$1;-><init>(Lchat/ola/vn/checkin/OlaCheckInActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    const v0, 0x7f090453

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInActivity$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInActivity$2;-><init>(Lchat/ola/vn/checkin/OlaCheckInActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->e:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInActivity$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInActivity$3;-><init>(Lchat/ola/vn/checkin/OlaCheckInActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->e:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInActivity$4;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInActivity$4;-><init>(Lchat/ola/vn/checkin/OlaCheckInActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    const v0, 0x7f0903e9

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->g:Landroid/view/View;

    const v0, 0x7f090319

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->f:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->f:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInActivity$5;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInActivity$5;-><init>(Lchat/ola/vn/checkin/OlaCheckInActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0b0083

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->f:Landroid/widget/ListView;

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;)V

    const v1, 0x7f0905ce

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->h:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->h:Landroid/view/View;

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f090597

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->i:Landroid/widget/TextView;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    const v0, 0x7f0903a1

    :try_start_2
    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f0471

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a4

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private E()V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/b/p;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/p;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->j:Lchat/ola/vn/b/p;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->j:Lchat/ola/vn/b/p;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/p;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->j:Lchat/ola/vn/b/p;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/p;->a(Lchat/ola/vn/b/p$a;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->j:Lchat/ola/vn/b/p;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/p;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->f:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->j:Lchat/ola/vn/b/p;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->j:Lchat/ola/vn/b/p;

    invoke-virtual {v0}, Lchat/ola/vn/b/p;->notifyDataSetChanged()V

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Z)V

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/checkin/OlaCheckInActivity;->e(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private F()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x0

    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->j:Lchat/ola/vn/b/p;

    invoke-virtual {v2}, Lchat/ola/vn/b/p;->getCount()I

    move-result v2

    :goto_0
    if-ge v1, v2, :cond_1

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->j:Lchat/ola/vn/b/p;

    invoke-virtual {v3, v1}, Lchat/ola/vn/b/p;->a(I)Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaVenueEntity;->c()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-direct {p0, v3}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Lchat/ola/vn/entity/OlaVenueEntity;)V

    return-void

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    new-instance v1, Lchat/ola/vn/checkin/OlaCheckInActivity$7;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaCheckInActivity$7;-><init>(Lchat/ola/vn/checkin/OlaCheckInActivity;)V

    invoke-static {p0, v0, v1}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->a(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/checkin/b;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    return-void
.end method

.method private G()V
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->n:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->a()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-object v1, v0

    :goto_0
    :try_start_1
    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v2, :cond_0

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->m:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v0, v3, v1, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/a;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaCheckInActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->e:Landroid/widget/EditText;

    return-object p0
.end method

.method private a(Ljava/util/List;Ljava/lang/String;)Lchat/ola/vn/entity/OlaVenueEntity;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Lchat/ola/vn/entity/OlaVenueEntity;"
        }
    .end annotation

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->c()Ljava/lang/String;

    move-result-object v1

    invoke-static {p2, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    return-object v0

    :catch_0
    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/checkin/b;)V
    .locals 1

    :try_start_0
    sput-object p1, Lchat/ola/vn/checkin/OlaCheckInActivity;->p:Lchat/ola/vn/checkin/b;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/checkin/OlaCheckInActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v0, 0x20000

    invoke-virtual {p1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const v0, 0x7f010039

    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaCheckInActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->o:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/checkin/OlaCheckInActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->i:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/checkin/OlaCheckInActivity;)Lchat/ola/vn/b/p;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->j:Lchat/ola/vn/b/p;

    return-object p0
.end method

.method private c(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/checkin/OlaCheckInActivity$6;

    invoke-direct {v0, p0}, Lchat/ola/vn/checkin/OlaCheckInActivity$6;-><init>(Lchat/ola/vn/checkin/OlaCheckInActivity;)V

    invoke-static {p0, p1, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Landroid/content/Context;Lchat/ola/vn/entity/OlaVenueEntity;Lchat/ola/vn/checkin/b;)V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/checkin/OlaCheckInActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->F()V

    return-void
.end method

.method private e(Ljava/lang/String;I)V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_3

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1, p2, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ILchat/ola/vn/p/a;)V

    return-void

    :cond_1
    :goto_0
    invoke-static {p0}, Lchat/ola/vn/n/b;->c(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_2

    const p1, 0x7f0f00a2

    const p2, 0x7f0f02a2

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :cond_2
    invoke-static {p0}, Lchat/ola/vn/i/i;->e(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    return-void
.end method


# virtual methods
.method public B()Z
    .locals 1

    iget v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->l:I

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

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->o:Z

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->a(Ljava/util/List;Ljava/lang/String;)Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p1, :cond_2

    const/4 v0, 0x1

    :try_start_1
    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Z)V

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->m:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->G()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_0
    move-exception p1

    :try_start_2
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :cond_1
    :goto_0
    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->l:I

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->e:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    iget v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->l:I

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->e(Ljava/lang/String;I)V

    :catch_1
    :cond_2
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
    .locals 2

    const/4 v0, 0x7

    const/4 v1, 0x0

    if-eq p1, v0, :cond_1

    packed-switch p1, :pswitch_data_0

    goto :goto_2

    :pswitch_0
    return-void

    :pswitch_1
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->k:Ljava/util/List;

    iput v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->l:I

    iget-boolean p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->o:Z

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->F()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    goto :goto_1

    :catch_1
    move-exception p1

    :try_start_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    invoke-virtual {p0, v1}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Z)V

    goto :goto_2

    :cond_1
    :pswitch_2
    invoke-virtual {p0, v1}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Z)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    const/4 p1, 0x0

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_2
    :goto_2
    :pswitch_3
    invoke-virtual {p0, v1}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Z)V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_1
        :pswitch_0
        :pswitch_2
        :pswitch_2
    .end packed-switch
.end method

.method public a_(I)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->e:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    iget v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->l:I

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->e(Ljava/lang/String;I)V

    return-void
.end method

.method public b(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/util/List;I)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;I)V"
        }
    .end annotation

    const/4 v0, 0x0

    if-eqz p1, :cond_4

    :try_start_0
    iget v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->l:I

    if-nez v1, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->k:Ljava/util/List;

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->k:Ljava/util/List;

    if-nez v1, :cond_1

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->k:Ljava/util/List;

    :cond_1
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    const/4 v2, 0x0

    :goto_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    if-ge v2, v3, :cond_2

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->k:Ljava/util/List;

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->j:Lchat/ola/vn/b/p;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->k:Ljava/util/List;

    invoke-virtual {p1, v1}, Lchat/ola/vn/b/p;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->j:Lchat/ola/vn/b/p;

    invoke-virtual {p1}, Lchat/ola/vn/b/p;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-boolean p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->o:Z

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->k:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, p1, v1}, Lchat/ola/vn/checkin/OlaCheckInActivity;->a(Ljava/util/List;Ljava/lang/String;)Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object p1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    if-eqz p1, :cond_3

    const/4 v1, 0x1

    :try_start_2
    invoke-virtual {p0, v1}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Z)V

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->m:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->G()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    :try_start_3
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_2

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->F()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_2

    :catch_1
    move-exception p1

    goto :goto_3

    :catch_2
    :cond_4
    :goto_2
    :try_start_4
    iput p2, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->l:I
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_4

    :goto_3
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_4
    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Z)V

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

.method public c(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->g:Landroid/view/View;

    if-eqz v0, :cond_1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->g:Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->g:Landroid/view/View;

    const/16 v0, 0x8

    goto :goto_0

    :cond_1
    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "extra_check_in_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "_byte_data"

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->m:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->h()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/4 p1, -0x1

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Z)V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/checkin/OlaCheckInActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->F()V

    return-void

    :sswitch_1
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Z)V

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/OlaVenueEntity;

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->m:Lchat/ola/vn/entity/OlaVenueEntity;

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->m:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Lchat/ola/vn/entity/OlaVenueEntity;)V

    return-void

    :sswitch_2
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity;->f:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->smoothScrollToPosition(I)V

    return-void

    :sswitch_3
    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->finish()V

    return-void

    :sswitch_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f0900c6 -> :sswitch_4
        0x7f09039c -> :sswitch_3
        0x7f0903a1 -> :sswitch_3
        0x7f0903a4 -> :sswitch_2
        0x7f0905ca -> :sswitch_1
        0x7f0905ce -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0047

    invoke-virtual {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->D()V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->E()V

    return-void
.end method
