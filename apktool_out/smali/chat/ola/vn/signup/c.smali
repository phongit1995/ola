.class public Lchat/ola/vn/signup/c;
.super Lchat/ola/vn/signup/a;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field public static a:Ljava/lang/String;


# instance fields
.field private b:Landroid/widget/EditText;

.field private c:Landroid/widget/EditText;

.field private d:Landroid/widget/TextView;

.field private e:Landroid/view/animation/Animation;

.field private f:Landroid/view/View;

.field private g:Ljava/lang/Runnable;

.field private h:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private i:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/signup/a;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/signup/c;->g:Ljava/lang/Runnable;

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/signup/c;->i:I

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/signup/c;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/signup/c;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/c;->g:Ljava/lang/Runnable;

    return-object p1
.end method

.method static synthetic b(Lchat/ola/vn/signup/c;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/c;->g:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/signup/c;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/c;->b:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/signup/c;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/signup/c;->y()V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/signup/c;)I
    .locals 1

    iget v0, p0, Lchat/ola/vn/signup/c;->i:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lchat/ola/vn/signup/c;->i:I

    return v0
.end method

.method static synthetic f(Lchat/ola/vn/signup/c;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/c;->c:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic g(Lchat/ola/vn/signup/c;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/signup/c;->i:I

    return p0
.end method

.method static synthetic h(Lchat/ola/vn/signup/c;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/c;->h:Ljava/util/List;

    return-object p0
.end method

.method static synthetic i(Lchat/ola/vn/signup/c;)Landroid/view/animation/Animation;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/c;->e:Landroid/view/animation/Animation;

    return-object p0
.end method

.method private y()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/c;->b:Landroid/widget/EditText;

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

    const/4 v2, 0x0

    if-nez v1, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v3, 0x6

    if-ge v1, v3, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->isLetter(C)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    const v1, 0x7f0f0267

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    const v1, 0x7f0f0266

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v2, Lchat/ola/vn/signup/c$4;

    invoke-direct {v2, p0}, Lchat/ola/vn/signup/c$4;-><init>(Lchat/ola/vn/signup/c;)V

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/j;)V

    return-void

    :cond_3
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    const v1, 0x7f0f025f

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method


# virtual methods
.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    const/4 p2, 0x3

    const/4 p3, 0x0

    if-eq p1, p2, :cond_2

    const/4 p2, 0x7

    if-eq p1, p2, :cond_1

    const/16 p2, 0xa

    if-eq p1, p2, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/signup/c;->c:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/signup/c;->c:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/signup/c;->e:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    invoke-virtual {p0}, Lchat/ola/vn/signup/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const p2, 0x7f0f0253

    invoke-static {p1, p2}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/signup/c;->b:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/signup/c;->b:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/signup/c;->e:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    sget p2, Lchat/ola/vn/f;->k:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    const p2, 0x7f0f0266

    invoke-virtual {p0, p2}, Lchat/ola/vn/signup/c;->getString(I)Ljava/lang/String;

    move-result-object p2

    :goto_0
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/signup/c;->b:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/signup/c;->b:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/signup/c;->e:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    sget p2, Lchat/ola/vn/f;->k:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    const p2, 0x7f0f0265

    invoke-virtual {p0, p2}, Lchat/ola/vn/signup/c;->getString(I)Ljava/lang/String;

    move-result-object p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/signup/a;->b(Landroid/os/Bundle;)V

    return-void
.end method

.method public c()Lchat/ola/vn/signup/a;
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/signup/d;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/signup/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public e()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f044d

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

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

    const v0, 0x7f0f0574

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090373

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/c;->x()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    const/4 p2, 0x0

    const p3, 0x7f0b016b

    invoke-virtual {p1, p3, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p3, 0x7f0904e4

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/TextView;

    iput-object p3, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    const p3, 0x7f090570

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/EditText;

    iput-object p3, p0, Lchat/ola/vn/signup/c;->b:Landroid/widget/EditText;

    const p3, 0x7f090576

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/EditText;

    iput-object p3, p0, Lchat/ola/vn/signup/c;->c:Landroid/widget/EditText;

    iget-object p3, p0, Lchat/ola/vn/signup/c;->b:Landroid/widget/EditText;

    new-instance v0, Lchat/ola/vn/signup/c$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/signup/c$1;-><init>(Lchat/ola/vn/signup/c;)V

    invoke-virtual {p3, v0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    :try_start_0
    sget-object p3, Lchat/ola/vn/signup/c;->a:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    const/4 v0, 0x0

    if-eqz p3, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/signup/c;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/signup/OlaSignUpActivity;->a(Landroid/content/Context;)Ljava/util/List;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/signup/c;->h:Ljava/util/List;

    iget-object p2, p0, Lchat/ola/vn/signup/c;->h:Ljava/util/List;

    if-eqz p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/signup/c;->h:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    if-lez p2, :cond_1

    iput v0, p0, Lchat/ola/vn/signup/c;->i:I

    iget-object p2, p0, Lchat/ola/vn/signup/c;->b:Landroid/widget/EditText;

    const-string p3, ""

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lchat/ola/vn/signup/c;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p2

    const/4 p3, 0x1

    invoke-virtual {p2, p3}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    iget-object p2, p0, Lchat/ola/vn/signup/c;->h:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    :goto_0
    if-ge v0, p2, :cond_1

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/signup/c;->h:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    new-instance v2, Lchat/ola/vn/signup/c$2;

    invoke-direct {v2, p0}, Lchat/ola/vn/signup/c$2;-><init>(Lchat/ola/vn/signup/c;)V

    invoke-virtual {p3, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/j;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/c;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p3

    invoke-virtual {p3, v0}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    iget-object p3, p0, Lchat/ola/vn/signup/c;->b:Landroid/widget/EditText;

    sget-object v0, Lchat/ola/vn/signup/c;->a:Ljava/lang/String;

    invoke-virtual {p3, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p3, p0, Lchat/ola/vn/signup/c;->c:Landroid/widget/EditText;

    invoke-virtual {p3}, Landroid/widget/EditText;->requestFocus()Z

    sput-object p2, Lchat/ola/vn/signup/c;->a:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p2

    invoke-virtual {p2}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    :goto_1
    iget-object p2, p0, Lchat/ola/vn/signup/c;->c:Landroid/widget/EditText;

    new-instance p3, Lchat/ola/vn/signup/c$3;

    invoke-direct {p3, p0}, Lchat/ola/vn/signup/c$3;-><init>(Lchat/ola/vn/signup/c;)V

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    invoke-virtual {p0}, Lchat/ola/vn/signup/c;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p2

    const p3, 0x7f010042

    invoke-static {p2, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/signup/c;->e:Landroid/view/animation/Animation;

    const p2, 0x7f090373

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/signup/c;->f:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/signup/c;->f:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-object p1
.end method

.method public x()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/c;->b:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/signup/c;->c:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v0, v2

    :catch_0
    :try_start_2
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_6

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v4, 0x6

    if-ge v2, v4, :cond_0

    goto/16 :goto_1

    :cond_0
    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isLetter(C)Z

    move-result v2

    if-nez v2, :cond_1

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    const v1, 0x7f0f0267

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_5

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v2, v4, :cond_2

    goto :goto_0

    :cond_2
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    const v1, 0x7f0f0266

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lchat/ola/vn/signup/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f00a2

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/signup/c;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object v2

    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    sget-object v2, Lchat/ola/vn/signup/OlaSignUpActivity;->k:[B

    if-nez v2, :cond_4

    sget-object v2, Lchat/ola/vn/signup/OlaSignUpActivity;->m:Ljava/lang/String;

    if-nez v2, :cond_4

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->i(S)V

    :cond_4
    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v3, Lchat/ola/vn/signup/c$5;

    invoke-direct {v3, p0, v1}, Lchat/ola/vn/signup/c$5;-><init>(Lchat/ola/vn/signup/c;Ljava/lang/String;)V

    invoke-virtual {v2, v0, v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/j;)V

    return-void

    :cond_5
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/signup/c;->c:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    iget-object v0, p0, Lchat/ola/vn/signup/c;->c:Landroid/widget/EditText;

    iget-object v1, p0, Lchat/ola/vn/signup/c;->e:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    invoke-virtual {p0}, Lchat/ola/vn/signup/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f025e

    invoke-static {v0, v1}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V

    return-void

    :cond_6
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/c;->d:Landroid/widget/TextView;

    const v1, 0x7f0f025f

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method
