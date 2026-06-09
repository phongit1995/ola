.class public Lchat/ola/vn/signup/fb/d;
.super Lchat/ola/vn/signup/fb/b;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field static a:Ljava/lang/String; = null

.field static b:Ljava/lang/String; = null

.field static c:Ljava/lang/String; = null

.field static d:J = 0x0L

.field static e:B = 0x2t


# instance fields
.field private f:Landroid/widget/EditText;

.field private g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private h:Landroid/widget/TextView;

.field private i:Landroid/view/View;

.field private j:Landroid/view/animation/Animation;

.field private k:Landroid/view/View;

.field private l:Landroid/view/View;

.field private m:Ljava/lang/Runnable;

.field private n:S

.field private o:Lchat/ola/vn/network/c;
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "InlinedApi",
            "NewApi"
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

    invoke-direct {p0}, Lchat/ola/vn/signup/fb/b;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/signup/fb/d;->m:Ljava/lang/Runnable;

    const/4 v0, -0x1

    iput-short v0, p0, Lchat/ola/vn/signup/fb/d;->n:S

    new-instance v0, Lchat/ola/vn/signup/fb/d$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/signup/fb/d$3;-><init>(Lchat/ola/vn/signup/fb/d;)V

    iput-object v0, p0, Lchat/ola/vn/signup/fb/d;->o:Lchat/ola/vn/network/c;

    return-void
.end method

.method private A()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x6

    if-gt v0, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    iget-object v2, p0, Lchat/ola/vn/signup/fb/d;->j:Landroid/view/animation/Animation;

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    const v1, 0x7f0f025f

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/signup/fb/d;->b:Ljava/lang/String;

    sget-object v0, Lchat/ola/vn/signup/fb/d;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    const v1, 0x7f0f0266

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f00a2

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->c(Z)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "fb:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/j/a;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/signup/fb/d;->a:Ljava/lang/String;

    sget-object v2, Lchat/ola/vn/signup/fb/d;->b:Ljava/lang/String;

    sget-object v3, Lchat/ola/vn/signup/fb/d;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/signup/fb/d;->o:Lchat/ola/vn/network/c;

    invoke-static {v1, v2, v0, v3, v4}, Lchat/ola/vn/l/b;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/c;)V

    return-void
.end method

.method private B()Lcom/facebook/GraphRequest;
    .locals 2

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/signup/fb/d$6;

    invoke-direct {v1, p0}, Lchat/ola/vn/signup/fb/d$6;-><init>(Lchat/ola/vn/signup/fb/d;)V

    invoke-static {v0, v1}, Lcom/facebook/GraphRequest;->newMeRequest(Lcom/facebook/AccessToken;Lcom/facebook/GraphRequest$GraphJSONObjectCallback;)Lcom/facebook/GraphRequest;

    move-result-object v0

    return-object v0
.end method

.method private C()V
    .locals 3

    const/4 v0, 0x1

    new-array v0, v0, [Lcom/facebook/GraphRequest;

    invoke-direct {p0}, Lchat/ola/vn/signup/fb/d;->B()Lcom/facebook/GraphRequest;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    invoke-static {v0}, Lcom/facebook/GraphRequest;->executeBatchAsync([Lcom/facebook/GraphRequest;)Lcom/facebook/GraphRequestAsyncTask;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/signup/fb/d;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/fb/d;->m:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/signup/fb/d;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/d;->m:Ljava/lang/Runnable;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/signup/fb/d;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/d;->g:Ljava/util/List;

    return-object p1
.end method

.method private a(Landroid/view/View;)V
    .locals 2

    const v0, 0x7f0904e5

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/signup/fb/d$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/signup/fb/d$1;-><init>(Lchat/ola/vn/signup/fb/d;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/signup/fb/d$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/signup/fb/d$2;-><init>(Lchat/ola/vn/signup/fb/d;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    const v0, 0x7f0904e4

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    const v0, 0x7f0904e7

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/signup/fb/d;->k:Landroid/view/View;

    const v0, 0x7f090373

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/signup/fb/d;->l:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->l:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09009b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/signup/fb/d;->i:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->i:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090066

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0}, Lchat/ola/vn/signup/fb/d;->C()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/signup/fb/d;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/signup/fb/d;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/signup/fb/d;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/signup/fb/d;->x()V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/fb/d;->k:Landroid/view/View;

    return-object p0
.end method

.method static synthetic f(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/fb/d;->l:Landroid/view/View;

    return-object p0
.end method

.method static synthetic g(Lchat/ola/vn/signup/fb/d;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/signup/fb/d;->A()V

    return-void
.end method

.method static synthetic h(Lchat/ola/vn/signup/fb/d;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/fb/d;->g:Ljava/util/List;

    return-object p0
.end method

.method static synthetic i(Lchat/ola/vn/signup/fb/d;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/signup/fb/d;->y()V

    return-void
.end method

.method private x()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v0, v1

    :catch_0
    :try_start_2
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x6

    if-ge v1, v2, :cond_0

    goto :goto_0

    :cond_0
    sget-object v1, Lchat/ola/vn/signup/fb/d;->a:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/signup/fb/d;->o:Lchat/ola/vn/network/c;

    invoke-static {v1, v0, v2}, Lchat/ola/vn/l/b;->c(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/c;)V

    return-void

    :cond_1
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    const/high16 v1, -0x10000

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    const v1, 0x7f0f025f

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private y()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->g:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->g:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->i:Landroid/view/View;

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->i:Landroid/view/View;

    const/16 v1, 0x8

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method private z()V
    .locals 2

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/AccessToken;->isExpired()Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/signup/fb/d;->a:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/signup/fb/d;->a:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/signup/fb/d;->o:Lchat/ola/vn/network/c;

    invoke-static {v0, v1}, Lchat/ola/vn/l/b;->c(Ljava/lang/String;Lchat/ola/vn/network/c;)V

    :cond_0
    return-void
.end method


# virtual methods
.method protected b(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/signup/fb/b;->b(Landroid/os/Bundle;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/signup/fb/d;->b:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    sget-object v0, Lchat/ola/vn/signup/fb/d;->b:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    iget-short p1, p0, Lchat/ola/vn/signup/fb/d;->n:S

    const/4 v0, 0x3

    if-eq p1, v0, :cond_1

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    sget v0, Lchat/ola/vn/f;->k:I

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d;->h:Landroid/widget/TextView;

    const v0, 0x7f0f0265

    invoke-virtual {p0, v0}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d;->k:Landroid/view/View;

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d;->l:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c()Lchat/ola/vn/signup/fb/b;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f05dc

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public h()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f04f5

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public j()V
    .locals 0

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/signup/fb/d;->A()V
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

    const v0, 0x7f090066

    if-eq p1, v0, :cond_2

    const v0, 0x7f09009b

    if-eq p1, v0, :cond_1

    const v0, 0x7f0900be

    if-eq p1, v0, :cond_2

    const v0, 0x7f090373

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/signup/fb/d;->A()V

    goto :goto_0

    :cond_1
    new-instance p1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->g:Ljava/util/List;

    invoke-virtual {p1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v0, Lchat/ola/vn/signup/fb/d$5;

    invoke-direct {v0, p0}, Lchat/ola/vn/signup/fb/d$5;-><init>(Lchat/ola/vn/signup/fb/d;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {p1}, Lchat/ola/vn/i/m;->show()V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f041f

    const v2, 0x7f0f0420

    const v3, 0x7f0f048f

    const v4, 0x7f0f0548

    new-instance v5, Lchat/ola/vn/signup/fb/d$4;

    invoke-direct {v5, p0}, Lchat/ola/vn/signup/fb/d$4;-><init>(Lchat/ola/vn/signup/fb/d;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    goto :goto_0

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/d;->v()V

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d;->f:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/signup/fb/b;->onCreate(Landroid/os/Bundle;)V

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/d;->getArguments()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "_result"

    const/4 v1, -0x1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->getShort(Ljava/lang/String;S)S

    move-result p1

    iput-short p1, p0, Lchat/ola/vn/signup/fb/d;->n:S
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const p2, 0x7f0b0197

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/d;->getArguments()Landroid/os/Bundle;

    move-result-object p2

    const-string p3, "_result"

    const/4 v0, -0x1

    invoke-virtual {p2, p3, v0}, Landroid/os/Bundle;->getShort(Ljava/lang/String;S)S

    move-result p2

    iput-short p2, p0, Lchat/ola/vn/signup/fb/d;->n:S
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-direct {p0, p1}, Lchat/ola/vn/signup/fb/d;->a(Landroid/view/View;)V

    invoke-direct {p0}, Lchat/ola/vn/signup/fb/d;->z()V

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p2

    const p3, 0x7f010042

    invoke-static {p2, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/signup/fb/d;->j:Landroid/view/animation/Animation;

    return-object p1
.end method
