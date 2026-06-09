.class public Lchat/ola/vn/game/caro/CaroActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/game/caro/c;
.implements Lchat/ola/vn/game/caro/d$a;


# static fields
.field private static q:Ljava/lang/String;

.field private static r:Landroid/widget/TextView;


# instance fields
.field e:I

.field f:I

.field g:I

.field h:I

.field i:[I

.field j:[I

.field k:I

.field private l:Landroid/widget/ScrollView;

.field private m:Landroid/widget/HorizontalScrollView;

.field private n:Landroid/widget/LinearLayout;

.field private o:Lchat/ola/vn/game/caro/d;

.field private p:Lchat/ola/vn/game/caro/b;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x4

    new-array v1, v0, [I

    fill-array-data v1, :array_0

    iput-object v1, p0, Lchat/ola/vn/game/caro/CaroActivity;->i:[I

    new-array v0, v0, [I

    fill-array-data v0, :array_1

    iput-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->j:[I

    return-void

    nop

    :array_0
    .array-data 4
        0x0
        -0x1
        -0x1
        -0x1
    .end array-data

    :array_1
    .array-data 4
        -0x1
        -0x1
        0x0
        0x1
    .end array-data
.end method

.method static synthetic C()Ljava/lang/String;
    .locals 1

    sget-object v0, Lchat/ola/vn/game/caro/CaroActivity;->q:Ljava/lang/String;

    return-object v0
.end method

.method private D()V
    .locals 4

    const v0, 0x7f0b0031

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/CaroActivity;->setContentView(I)V

    const v0, 0x7f0905c3

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/CaroActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->n:Landroid/widget/LinearLayout;

    const v0, 0x7f09044c

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/CaroActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ScrollView;

    iput-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->l:Landroid/widget/ScrollView;

    const v0, 0x7f09024d

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/CaroActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/HorizontalScrollView;

    iput-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->m:Landroid/widget/HorizontalScrollView;

    new-instance v0, Lchat/ola/vn/game/caro/d;

    invoke-direct {v0, p0}, Lchat/ola/vn/game/caro/d;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    const v0, 0x7f0904e9

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/CaroActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lchat/ola/vn/game/caro/CaroActivity;->r:Landroid/widget/TextView;

    const v0, 0x7f090263

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/CaroActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09027c

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/CaroActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0900be

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/CaroActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090115

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/CaroActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/game/caro/CaroActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "row"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    invoke-virtual {p0}, Lchat/ola/vn/game/caro/CaroActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    const-string v3, "col"

    invoke-virtual {v1, v3, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    invoke-virtual {v2, v0, v1}, Lchat/ola/vn/game/caro/d;->c(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->n:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    invoke-virtual {v0, p0}, Lchat/ola/vn/game/caro/d;->setCaroViewListener(Lchat/ola/vn/game/caro/d$a;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private E()V
    .locals 3

    :try_start_0
    sget-object v0, Lchat/ola/vn/game/caro/CaroActivity;->q:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v1, Lchat/ola/vn/game/caro/CaroActivity;->q:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_1

    sget-object v1, Lchat/ola/vn/game/caro/CaroActivity;->r:Landroid/widget/TextView;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method private F()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    iget-object v1, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v1}, Lchat/ola/vn/game/caro/b;->c()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/game/caro/d;->setXList(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    iget-object v1, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v1}, Lchat/ola/vn/game/caro/b;->d()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/game/caro/d;->setOList(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v0}, Lchat/ola/vn/game/caro/b;->e()Lchat/ola/vn/game/caro/a;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance v0, Landroid/graphics/Point;

    iget-object v1, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v1}, Lchat/ola/vn/game/caro/b;->e()Lchat/ola/vn/game/caro/a;

    move-result-object v1

    iget v1, v1, Lchat/ola/vn/game/caro/a;->d:I

    sget v2, Lchat/ola/vn/game/caro/d;->a:I

    mul-int v1, v1, v2

    iget-object v2, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v2}, Lchat/ola/vn/game/caro/b;->e()Lchat/ola/vn/game/caro/a;

    move-result-object v2

    iget v2, v2, Lchat/ola/vn/game/caro/a;->c:I

    sget v3, Lchat/ola/vn/game/caro/d;->a:I

    mul-int v2, v2, v3

    invoke-direct {v0, v1, v2}, Landroid/graphics/Point;-><init>(II)V

    iget-object v1, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    invoke-virtual {v1, v0}, Lchat/ola/vn/game/caro/d;->a(Landroid/graphics/Point;)V

    iget v1, v0, Landroid/graphics/Point;->x:I

    iget v0, v0, Landroid/graphics/Point;->y:I

    invoke-direct {p0, v1, v0}, Lchat/ola/vn/game/caro/CaroActivity;->c(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    invoke-virtual {v0}, Lchat/ola/vn/game/caro/d;->invalidate()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method private G()V
    .locals 3

    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v1, Lchat/ola/vn/game/caro/CaroActivity;->q:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->t(Ljava/lang/String;S)V

    const v0, 0x7f0f0280

    const v1, 0x7f0f061b

    invoke-static {p0, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/game/caro/CaroActivity;)Landroid/widget/ScrollView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/game/caro/CaroActivity;->l:Landroid/widget/ScrollView;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/game/caro/CaroActivity;Lchat/ola/vn/game/caro/b;)Lchat/ola/vn/game/caro/b;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    return-object p1
.end method

.method static synthetic b(Lchat/ola/vn/game/caro/CaroActivity;)Landroid/widget/HorizontalScrollView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/game/caro/CaroActivity;->m:Landroid/widget/HorizontalScrollView;

    return-object p0
.end method

.method private c(II)V
    .locals 2

    :try_start_0
    sget v0, Lchat/ola/vn/e;->c:I

    div-int/lit8 v0, v0, 0x2

    sub-int/2addr p1, v0

    const/4 v0, 0x0

    if-gez p1, :cond_0

    const/4 p1, 0x0

    :cond_0
    sget v1, Lchat/ola/vn/e;->d:I

    div-int/lit8 v1, v1, 0x2

    sub-int/2addr p2, v1

    if-gez p2, :cond_1

    const/4 p2, 0x0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->l:Landroid/widget/ScrollView;

    new-instance v1, Lchat/ola/vn/game/caro/CaroActivity$1;

    invoke-direct {v1, p0, p1, p2}, Lchat/ola/vn/game/caro/CaroActivity$1;-><init>(Lchat/ola/vn/game/caro/CaroActivity;II)V

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->post(Ljava/lang/Runnable;)Z

    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->m:Landroid/widget/HorizontalScrollView;

    new-instance v1, Lchat/ola/vn/game/caro/CaroActivity$2;

    invoke-direct {v1, p0, p1, p2}, Lchat/ola/vn/game/caro/CaroActivity$2;-><init>(Lchat/ola/vn/game/caro/CaroActivity;II)V

    invoke-virtual {v0, v1}, Landroid/widget/HorizontalScrollView;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/game/caro/CaroActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/game/caro/CaroActivity;->G()V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/game/caro/CaroActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/game/caro/CaroActivity;->F()V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/game/caro/CaroActivity;)Lchat/ola/vn/game/caro/d;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    return-object p0
.end method


# virtual methods
.method public B()V
    .locals 0

    invoke-virtual {p0}, Lchat/ola/vn/game/caro/CaroActivity;->finish()V

    return-void
.end method

.method protected a()V
    .locals 3

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v1, Lchat/ola/vn/game/caro/CaroActivity;->q:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v0, p0}, Lchat/ola/vn/game/caro/b;->a(Lchat/ola/vn/game/caro/c;)V

    invoke-direct {p0}, Lchat/ola/vn/game/caro/CaroActivity;->F()V

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/game/caro/CaroActivity;->E()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(II)V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v0}, Lchat/ola/vn/game/caro/b;->g()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    iget-object v1, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v1}, Lchat/ola/vn/game/caro/b;->f()Z

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    sget-short v1, Lchat/ola/vn/game/caro/a;->b:S

    goto :goto_0

    :cond_0
    sget-short v1, Lchat/ola/vn/game/caro/a;->a:S

    :goto_0
    invoke-virtual {v0, p1, p2, v1}, Lchat/ola/vn/game/caro/b;->a(IIS)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    const/4 v0, 0x2

    new-array v1, v0, [I

    const/4 v3, 0x0

    aput p1, v1, v3

    aput p2, v1, v2

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object p2, Lchat/ola/vn/game/caro/CaroActivity;->q:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-virtual {p1, p2, v0, v3, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;S[I[I)V

    iget-object p1, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {p1, v2}, Lchat/ola/vn/game/caro/b;->b(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/game/caro/a;)V
    .locals 10

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    invoke-virtual {v0, p1}, Lchat/ola/vn/game/caro/d;->a(Lchat/ola/vn/game/caro/a;)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v0}, Lchat/ola/vn/game/caro/b;->e()Lchat/ola/vn/game/caro/a;

    move-result-object v0

    if-eqz v0, :cond_2

    new-instance v0, Landroid/graphics/Point;

    iget-object v1, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v1}, Lchat/ola/vn/game/caro/b;->e()Lchat/ola/vn/game/caro/a;

    move-result-object v1

    iget v1, v1, Lchat/ola/vn/game/caro/a;->d:I

    sget v2, Lchat/ola/vn/game/caro/d;->a:I

    mul-int v1, v1, v2

    iget-object v2, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v2}, Lchat/ola/vn/game/caro/b;->e()Lchat/ola/vn/game/caro/a;

    move-result-object v2

    iget v2, v2, Lchat/ola/vn/game/caro/a;->c:I

    sget v3, Lchat/ola/vn/game/caro/d;->a:I

    mul-int v2, v2, v3

    invoke-direct {v0, v1, v2}, Landroid/graphics/Point;-><init>(II)V

    iget-object v1, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    iget v2, v0, Landroid/graphics/Point;->x:I

    iget v3, v0, Landroid/graphics/Point;->y:I

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/game/caro/d;->b(II)Z

    move-result v1

    if-nez v1, :cond_0

    iget v1, v0, Landroid/graphics/Point;->x:I

    iget v0, v0, Landroid/graphics/Point;->y:I

    invoke-direct {p0, v1, v0}, Lchat/ola/vn/game/caro/CaroActivity;->c(II)V

    :cond_0
    iget v0, p1, Lchat/ola/vn/game/caro/a;->d:I

    iget p1, p1, Lchat/ola/vn/game/caro/a;->c:I

    invoke-virtual {p0, v0, p1}, Lchat/ola/vn/game/caro/CaroActivity;->b(II)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    iget v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->e:I

    iget v1, p0, Lchat/ola/vn/game/caro/CaroActivity;->f:I

    iget v2, p0, Lchat/ola/vn/game/caro/CaroActivity;->g:I

    iget v3, p0, Lchat/ola/vn/game/caro/CaroActivity;->h:I

    invoke-virtual {p1, v0, v1, v2, v3}, Lchat/ola/vn/game/caro/d;->a(IIII)V

    new-instance v9, Lchat/ola/vn/game/caro/CaroActivity$3;

    invoke-direct {v9, p0}, Lchat/ola/vn/game/caro/CaroActivity$3;-><init>(Lchat/ola/vn/game/caro/CaroActivity;)V

    iget-object p1, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {p1}, Lchat/ola/vn/game/caro/b;->l()S

    move-result p1

    iget v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->k:I

    if-ne p1, v0, :cond_1

    const v5, 0x7f0f0280

    const v6, 0x7f0f03b1

    :goto_0
    const v7, 0x7f0f05a9

    const v8, 0x7f0f05cb

    move-object v4, p0

    invoke-static/range {v4 .. v9}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_1
    const v5, 0x7f0f0280

    const v6, 0x7f0f03af

    goto :goto_0

    :catch_0
    :cond_2
    return-void
.end method

.method a(III)[I
    .locals 6

    const/16 v0, 0xa

    new-array v0, v0, [I

    const/4 v1, 0x4

    move v2, p1

    move v3, p2

    :goto_0
    const/4 v4, -0x1

    if-ltz v1, :cond_1

    iget-object v5, p0, Lchat/ola/vn/game/caro/CaroActivity;->i:[I

    aget v5, v5, p3

    add-int/2addr v2, v5

    iget-object v5, p0, Lchat/ola/vn/game/caro/CaroActivity;->j:[I

    aget v5, v5, p3

    add-int/2addr v3, v5

    if-ltz v2, :cond_0

    if-ltz v3, :cond_0

    iget-object v5, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v5}, Lchat/ola/vn/game/caro/b;->b()I

    move-result v5

    if-ge v2, v5, :cond_0

    iget-object v5, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v5}, Lchat/ola/vn/game/caro/b;->a()I

    move-result v5

    if-ge v3, v5, :cond_0

    iget-object v4, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v4}, Lchat/ola/vn/game/caro/b;->k()[[I

    move-result-object v4

    aget-object v4, v4, v3

    aget v4, v4, v2

    aput v4, v0, v1

    goto :goto_1

    :cond_0
    aput v4, v0, v1

    :goto_1
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    :cond_1
    const/4 v1, 0x5

    :goto_2
    const/16 v2, 0x9

    if-gt v1, v2, :cond_3

    iget-object v2, p0, Lchat/ola/vn/game/caro/CaroActivity;->i:[I

    aget v2, v2, p3

    sub-int/2addr p1, v2

    iget-object v2, p0, Lchat/ola/vn/game/caro/CaroActivity;->j:[I

    aget v2, v2, p3

    sub-int/2addr p2, v2

    if-ltz p1, :cond_2

    if-ltz p2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v2}, Lchat/ola/vn/game/caro/b;->b()I

    move-result v2

    if-ge p1, v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v2}, Lchat/ola/vn/game/caro/b;->a()I

    move-result v2

    if-ge p2, v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v2}, Lchat/ola/vn/game/caro/b;->k()[[I

    move-result-object v2

    aget-object v2, v2, p2

    aget v2, v2, p1

    aput v2, v0, v1

    goto :goto_3

    :cond_2
    aput v4, v0, v1

    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_3
    return-object v0
.end method

.method public b(Ljava/lang/String;I)V
    .locals 6

    invoke-super {p0, p1, p2}, Lchat/ola/vn/c;->b(Ljava/lang/String;I)V

    sget-object p2, Lchat/ola/vn/game/caro/CaroActivity;->q:Ljava/lang/String;

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    const v1, 0x7f0f0280

    const v2, 0x7f0f02e7

    const v3, 0x7f0f0585

    const v4, 0x7f0f0577

    new-instance v5, Lchat/ola/vn/game/caro/CaroActivity$5;

    invoke-direct {v5, p0}, Lchat/ola/vn/game/caro/CaroActivity$5;-><init>(Lchat/ola/vn/game/caro/CaroActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    :cond_0
    return-void
.end method

.method b(II)Z
    .locals 11

    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v0}, Lchat/ola/vn/game/caro/b;->k()[[I

    move-result-object v0

    aget-object v0, v0, p2

    aget v0, v0, p1

    const/4 v1, 0x0

    const/4 v2, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2, v2}, Lchat/ola/vn/game/caro/CaroActivity;->a(III)[I

    move-result-object v3

    iput p1, p0, Lchat/ola/vn/game/caro/CaroActivity;->f:I

    iput p2, p0, Lchat/ola/vn/game/caro/CaroActivity;->e:I

    iput p1, p0, Lchat/ola/vn/game/caro/CaroActivity;->h:I

    iput p2, p0, Lchat/ola/vn/game/caro/CaroActivity;->g:I

    const/4 v4, 0x4

    const/4 v5, 0x1

    const/4 v6, 0x4

    const/4 v7, 0x1

    :goto_0
    if-ltz v6, :cond_1

    aget v8, v3, v6

    if-ne v8, v0, :cond_1

    if-eqz v0, :cond_1

    iget v8, p0, Lchat/ola/vn/game/caro/CaroActivity;->h:I

    iget-object v9, p0, Lchat/ola/vn/game/caro/CaroActivity;->i:[I

    aget v9, v9, v2

    add-int/2addr v8, v9

    iput v8, p0, Lchat/ola/vn/game/caro/CaroActivity;->h:I

    iget v8, p0, Lchat/ola/vn/game/caro/CaroActivity;->g:I

    iget-object v9, p0, Lchat/ola/vn/game/caro/CaroActivity;->j:[I

    aget v9, v9, v2

    add-int/2addr v8, v9

    iput v8, p0, Lchat/ola/vn/game/caro/CaroActivity;->g:I

    add-int/lit8 v7, v7, 0x1

    add-int/lit8 v6, v6, -0x1

    goto :goto_0

    :cond_1
    const/4 v6, 0x5

    move v8, v7

    const/4 v7, 0x5

    :goto_1
    const/16 v9, 0x9

    if-gt v7, v9, :cond_2

    aget v9, v3, v7

    if-ne v9, v0, :cond_2

    if-eqz v0, :cond_2

    iget v9, p0, Lchat/ola/vn/game/caro/CaroActivity;->f:I

    iget-object v10, p0, Lchat/ola/vn/game/caro/CaroActivity;->i:[I

    aget v10, v10, v2

    sub-int/2addr v9, v10

    iput v9, p0, Lchat/ola/vn/game/caro/CaroActivity;->f:I

    iget v9, p0, Lchat/ola/vn/game/caro/CaroActivity;->e:I

    iget-object v10, p0, Lchat/ola/vn/game/caro/CaroActivity;->j:[I

    aget v10, v10, v2

    sub-int/2addr v9, v10

    iput v9, p0, Lchat/ola/vn/game/caro/CaroActivity;->e:I

    add-int/lit8 v8, v8, 0x1

    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    :cond_2
    add-int/lit8 v2, v2, 0x1

    if-ge v2, v4, :cond_3

    if-lt v8, v6, :cond_0

    :cond_3
    if-ge v8, v6, :cond_4

    return v1

    :cond_4
    iput v0, p0, Lchat/ola/vn/game/caro/CaroActivity;->k:I

    return v5
.end method

.method public c(Ljava/lang/String;I)V
    .locals 1

    invoke-super {p0, p1, p2}, Lchat/ola/vn/c;->c(Ljava/lang/String;I)V

    sget-object p2, Lchat/ola/vn/game/caro/CaroActivity;->q:Ljava/lang/String;

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    const p1, 0x7f0f0280

    const p2, 0x7f0f0171

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object p2, Lchat/ola/vn/game/caro/CaroActivity;->q:Ljava/lang/String;

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/game/caro/b;->j()V

    iget-object p1, p0, Lchat/ola/vn/game/caro/CaroActivity;->o:Lchat/ola/vn/game/caro/d;

    invoke-virtual {p1}, Lchat/ola/vn/game/caro/d;->a()V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object p2, Lchat/ola/vn/game/caro/CaroActivity;->q:Ljava/lang/String;

    invoke-virtual {p1, p2, v0}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    iget-object p1, p0, Lchat/ola/vn/game/caro/CaroActivity;->p:Lchat/ola/vn/game/caro/b;

    invoke-virtual {p1, v0}, Lchat/ola/vn/game/caro/b;->b(Z)V

    invoke-direct {p0}, Lchat/ola/vn/game/caro/CaroActivity;->F()V

    :cond_0
    return-void
.end method

.method public d(Ljava/lang/String;I)V
    .locals 0

    invoke-super {p0, p1, p2}, Lchat/ola/vn/c;->d(Ljava/lang/String;I)V

    sget-object p2, Lchat/ola/vn/game/caro/CaroActivity;->q:Ljava/lang/String;

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    const p1, 0x7f0f0280

    const p2, 0x7f0f032c

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    :cond_0
    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/game/caro/CaroActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 6

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900be

    if-eq p1, v0, :cond_2

    const v0, 0x7f090115

    if-eq p1, v0, :cond_1

    const v0, 0x7f090263

    if-eq p1, v0, :cond_0

    const v0, 0x7f09027c

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/game/caro/CaroActivity;->finish()V

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/game/caro/CaroActivity;->G()V

    return-void

    :cond_2
    const v1, 0x7f0f0280

    const v2, 0x7f0f0235

    const v3, 0x7f0f0585

    const v4, 0x7f0f044d

    new-instance v5, Lchat/ola/vn/game/caro/CaroActivity$4;

    invoke-direct {v5, p0}, Lchat/ola/vn/game/caro/CaroActivity$4;-><init>(Lchat/ola/vn/game/caro/CaroActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    invoke-direct {p0}, Lchat/ola/vn/game/caro/CaroActivity;->D()V

    invoke-direct {p0}, Lchat/ola/vn/game/caro/CaroActivity;->E()V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/f;)V

    :cond_0
    return-void
.end method
