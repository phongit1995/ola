.class public Lchat/ola/vn/activity/CreateClanActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/activity/CreateClanActivity$a;
    }
.end annotation


# instance fields
.field protected e:Lchat/ola/vn/i/c;

.field private f:Landroid/widget/EditText;

.field private g:Landroid/view/animation/Animation;

.field private h:Lchat/ola/vn/activity/CreateClanActivity$a;

.field private i:Ljava/lang/String;

.field private j:Ljava/lang/String;

.field private k:Landroid/view/View;

.field private l:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->i:Ljava/lang/String;

    return-void
.end method

.method private B()V
    .locals 4

    invoke-direct {p0}, Lchat/ola/vn/activity/CreateClanActivity;->C()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->e:Lchat/ola/vn/i/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->e:Lchat/ola/vn/i/c;

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->e:Lchat/ola/vn/i/c;

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    goto :goto_0

    :cond_0
    new-instance v0, Lchat/ola/vn/i/c;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->e:Lchat/ola/vn/i/c;

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->e:Lchat/ola/vn/i/c;

    const v1, 0x7f0f01e6

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/CreateClanActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/c;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->e:Lchat/ola/vn/i/c;

    const-wide/16 v1, 0x3a98

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/CreateClanActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x2e

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->f(Ljava/lang/String;S)V

    :cond_1
    return-void
.end method

.method private C()Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->f:Landroid/widget/EditText;

    iget-object v1, p0, Lchat/ola/vn/activity/CreateClanActivity;->g:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    const v0, 0x7f0f0283

    invoke-static {p0, v0}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;I)V

    const/4 v0, 0x0

    return v0

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/CreateClanActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    if-eqz p1, :cond_0

    const-string v1, "clanId"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_0
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const v0, 0x7f010039

    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/CreateClanActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/CreateClanActivity;->B()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/CreateClanActivity;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/CreateClanActivity;->i:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/activity/CreateClanActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/CreateClanActivity;->k:Landroid/view/View;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/activity/CreateClanActivity;)Lchat/ola/vn/activity/CreateClanActivity$a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/CreateClanActivity;->h:Lchat/ola/vn/activity/CreateClanActivity$a;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/activity/CreateClanActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/CreateClanActivity;->l:Landroid/widget/TextView;

    return-object p0
.end method

.method private f(Ljava/lang/String;)V
    .locals 7

    const v0, 0x7f0f0496

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/CreateClanActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    iget-object v1, p0, Lchat/ola/vn/activity/CreateClanActivity;->j:Ljava/lang/String;

    const/4 v3, 0x0

    aput-object v1, v0, v3

    const v1, 0x7f0f020a

    invoke-virtual {p0, v1, v0}, Lchat/ola/vn/activity/CreateClanActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const v0, 0x7f0f0494

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/CreateClanActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v0, 0x7f0f044d

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/CreateClanActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/activity/CreateClanActivity$3;

    invoke-direct {v6, p0, p1}, Lchat/ola/vn/activity/CreateClanActivity$3;-><init>(Lchat/ola/vn/activity/CreateClanActivity;Ljava/lang/String;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/b;S)V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->e:Lchat/ola/vn/i/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->e:Lchat/ola/vn/i/c;

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    :cond_0
    iget-object v0, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->i:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->f:Landroid/widget/EditText;

    const/4 v1, 0x1

    invoke-static {p0, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->selectAll()V

    const/16 v0, 0x2e

    if-ne v0, p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity;->k:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p2, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity;->l:Landroid/widget/TextView;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity;->l:Landroid/widget/TextView;

    const/high16 v2, -0x10000

    invoke-virtual {p2, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity;->l:Landroid/widget/TextView;

    const v2, 0x7f0f01de

    new-array v1, v1, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "#"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v0

    invoke-virtual {p0, v2, v1}, Lchat/ola/vn/activity/CreateClanActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/activity/CreateClanActivity;->h:Lchat/ola/vn/activity/CreateClanActivity$a;

    iget-object v2, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    iget-object v3, p1, Lchat/ola/vn/entity/b;->b:Ljava/lang/String;

    iget-object v4, p1, Lchat/ola/vn/entity/b;->c:Ljava/lang/String;

    iget-object v5, p1, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    iget v6, p1, Lchat/ola/vn/entity/b;->f:I

    iget v7, p1, Lchat/ola/vn/entity/b;->h:I

    invoke-static/range {v1 .. v7}, Lchat/ola/vn/activity/CreateClanActivity$a;->a(Lchat/ola/vn/activity/CreateClanActivity$a;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;S)V
    .locals 1

    const/16 v0, 0x2e

    if-ne v0, p2, :cond_1

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity;->e:Lchat/ola/vn/i/c;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity;->e:Lchat/ola/vn/i/c;

    invoke-virtual {p2}, Lchat/ola/vn/i/c;->a()V

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->j:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->k:Landroid/view/View;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->h:Lchat/ola/vn/activity/CreateClanActivity$a;

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity$a;->b(Lchat/ola/vn/activity/CreateClanActivity$a;)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->l:Landroid/widget/TextView;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->l:Landroid/widget/TextView;

    const p2, -0xffff01

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->l:Landroid/widget/TextView;

    const p2, 0x7f0f01dd

    invoke-virtual {p0, p2}, Lchat/ola/vn/activity/CreateClanActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/CreateClanActivity;->overridePendingTransition(II)V
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
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    check-cast p1, Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, v0, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    :sswitch_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/CreateClanActivity;->finish()V

    return-void

    :sswitch_2
    invoke-direct {p0}, Lchat/ola/vn/activity/CreateClanActivity;->C()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/CreateClanActivity;->f(Ljava/lang/String;)V

    return-void

    :sswitch_3
    invoke-direct {p0}, Lchat/ola/vn/activity/CreateClanActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f09009e -> :sswitch_1
        0x7f0900b8 -> :sswitch_3
        0x7f0900c3 -> :sswitch_2
        0x7f090506 -> :sswitch_0
        0x7f090507 -> :sswitch_0
        0x7f09050b -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0084

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/CreateClanActivity;->setContentView(I)V

    const p1, 0x7f010042

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->g:Landroid/view/animation/Animation;

    const p1, 0x7f090509

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/CreateClanActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->f:Landroid/widget/EditText;

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/CreateClanActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "clanId"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity;->f:Landroid/widget/EditText;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "#"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->f:Landroid/widget/EditText;

    new-instance v0, Lchat/ola/vn/activity/CreateClanActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/CreateClanActivity$1;-><init>(Lchat/ola/vn/activity/CreateClanActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->f:Landroid/widget/EditText;

    new-instance v0, Lchat/ola/vn/activity/CreateClanActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/CreateClanActivity$2;-><init>(Lchat/ola/vn/activity/CreateClanActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    const p1, 0x7f0900c3

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/CreateClanActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->k:Landroid/view/View;

    const p1, 0x7f09050c

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/CreateClanActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->l:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->l:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->k:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09009e

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/CreateClanActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0900b8

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/CreateClanActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance p1, Lchat/ola/vn/activity/CreateClanActivity$a;

    const v0, 0x7f0902e2

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/CreateClanActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/activity/CreateClanActivity$a;-><init>(Lchat/ola/vn/activity/CreateClanActivity;Landroid/view/View;)V

    iput-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->h:Lchat/ola/vn/activity/CreateClanActivity$a;

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity;->h:Lchat/ola/vn/activity/CreateClanActivity$a;

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity$a;->b(Lchat/ola/vn/activity/CreateClanActivity$a;)V

    return-void
.end method
