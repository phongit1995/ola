.class public Lchat/ola/vn/signup/OlaSignUpBySmsActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/f/a;
.implements Lchat/ola/vn/sms/a$a;


# static fields
.field private static q:Z = false


# instance fields
.field private e:Landroid/widget/EditText;

.field private f:Landroid/view/View;

.field private g:Landroid/widget/TextView;

.field private h:Ljava/lang/Runnable;

.field private i:Ljava/lang/Runnable;

.field private j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private k:I

.field private l:Landroid/app/ProgressDialog;

.field private o:Ljava/lang/Runnable;

.field private p:Lchat/ola/vn/sms/a;

.field private r:J


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->k:I

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->r:J

    return-void
.end method

.method private B()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->e:Landroid/widget/EditText;

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

    if-nez v1, :cond_2

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

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    const v1, 0x7f0f0267

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v2, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;

    invoke-direct {v2, p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;-><init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/j;)V

    return-void

    :cond_2
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    const v1, 0x7f0f025f

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private C()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->e:Landroid/widget/EditText;

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

    if-nez v1, :cond_2

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

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    const v1, 0x7f0f0267

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->c(Z)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v2, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;

    invoke-direct {v2, p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;-><init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/j;)V

    return-void

    :cond_2
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    const v1, 0x7f0f025f

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private D()V
    .locals 1

    :try_start_0
    sget-boolean v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->q:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    sput-boolean v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->q:Z

    invoke-static {p0}, Lchat/ola/vn/signup/OlaSignUpActivity;->a(Lchat/ola/vn/c;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;J)J
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->r:J

    return-wide p1
.end method

.method static synthetic a(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;Landroid/app/ProgressDialog;)Landroid/app/ProgressDialog;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->l:Landroid/app/ProgressDialog;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->i:Ljava/lang/Runnable;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->C()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->d(Z)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->i:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->e:Landroid/widget/EditText;

    return-object p0
.end method

.method private d(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->o:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$7;

    invoke-direct {v0, p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$7;-><init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V

    iput-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->o:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->o:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->l:Landroid/app/ProgressDialog;

    if-nez p1, :cond_1

    const p1, 0x7f0f05ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    const v0, 0x7f0f02ef

    invoke-virtual {p0, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->l:Landroid/app/ProgressDialog;

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->l:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->show()V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->l:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->isShowing()Z

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->o:Ljava/lang/Runnable;

    const-wide/32 v0, 0xea60

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->l:Landroid/app/ProgressDialog;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->l:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->l:Landroid/app/ProgressDialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method

.method static synthetic e(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->B()V

    return-void
.end method

.method static synthetic f(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)I
    .locals 1

    iget v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->k:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->k:I

    return v0
.end method

.method static synthetic g(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->k:I

    return p0
.end method

.method static synthetic h(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->j:Ljava/util/List;

    return-object p0
.end method

.method static synthetic i(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->D()V

    return-void
.end method

.method static synthetic j(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->r:J

    return-wide v0
.end method

.method static synthetic k(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/app/ProgressDialog;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->l:Landroid/app/ProgressDialog;

    return-object p0
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method protected b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public c(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->h:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$4;-><init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V

    iput-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->h:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->h:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->h:Ljava/lang/Runnable;

    const-wide/32 v0, 0xea60

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->f:Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->f:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/16 v0, 0x8

    goto :goto_0

    :catch_0
    return-void
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    new-instance p1, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;

    invoke-direct {p1, p0, p2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;-><init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;Ljava/lang/String;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public finish()V
    .locals 2

    const/4 v0, 0x1

    sput-boolean v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->q:Z

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 2

    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    const/4 p2, 0x1

    if-ne p1, p2, :cond_0

    :try_start_0
    const-string p1, "_username"

    invoke-virtual {p3, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "_pass"

    invoke-virtual {p3, p2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    const/4 p3, 0x0

    invoke-virtual {p0, p3}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->c(Z)V

    new-instance p3, Landroid/content/Intent;

    invoke-direct {p3}, Landroid/content/Intent;-><init>()V

    const-string v1, "_username"

    invoke-virtual {p3, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "_pass"

    invoke-virtual {p3, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0, p3}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->setResult(ILandroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->finish()V

    return-void
.end method

.method public onBackPressed()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->f:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090373

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->onBackPressed()V

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->C()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0169

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->setContentView(I)V

    const/4 p1, 0x0

    sput-boolean p1, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->q:Z

    const v0, 0x7f09030e

    invoke-virtual {p0, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->f:Landroid/view/View;

    const v0, 0x7f0904e4

    invoke-virtual {p0, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g:Landroid/widget/TextView;

    const v0, 0x7f0904ba

    invoke-virtual {p0, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/OlaTextView;

    const v1, 0x7f0f0644

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    sget v2, Lchat/ola/vn/f;->a:I

    const/4 v3, 0x0

    const/4 v4, 0x1

    invoke-static {v3, v1, v3, v2, v4}, Lchat/ola/vn/util/i;->b(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaTextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaTextView;->setOlaSpanClickListener(Lcom/mg/ola/common/widget/OlaTextView$b;)V

    const v0, 0x7f090570

    invoke-virtual {p0, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->e:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->e:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$1;-><init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->e:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;-><init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/signup/OlaSignUpActivity;->a(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->j:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->j:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    iput p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->k:I

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->e:Landroid/widget/EditText;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0, v4}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->c(Z)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    :goto_0
    if-ge p1, v0, :cond_0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->j:Ljava/util/List;

    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    new-instance v3, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$3;

    invoke-direct {v3, p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$3;-><init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/j;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const v0, 0x7f0f05dc

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    const p1, 0x7f090373

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const v0, 0x7f0f042c

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :try_start_1
    new-instance p1, Lchat/ola/vn/sms/a;

    invoke-direct {p1}, Lchat/ola/vn/sms/a;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->p:Lchat/ola/vn/sms/a;

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->p:Lchat/ola/vn/sms/a;

    invoke-virtual {p1, p0}, Lchat/ola/vn/sms/a;->a(Lchat/ola/vn/sms/a$a;)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->p:Lchat/ola/vn/sms/a;

    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method protected onDestroy()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->p:Lchat/ola/vn/sms/a;

    invoke-virtual {p0, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    return-void
.end method

.method protected onStart()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->onStart()V

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->q:Z

    return-void
.end method
