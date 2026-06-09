.class public Lchat/ola/vn/transferken/b;
.super Lchat/ola/vn/transferken/a;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private a:Landroid/widget/TextView;

.field private b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field private c:Landroid/widget/EditText;

.field private d:Landroid/view/animation/Animation;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/transferken/a;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/transferken/b;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/transferken/b;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/transferken/b;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/transferken/b;->c:Landroid/widget/EditText;

    return-object p0
.end method

.method private v()Z
    .locals 8

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/transferken/b;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/transferken/b;->c:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    return v0

    :cond_0
    const-string v3, ","

    const-string v4, ""

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/transferken/b;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object v1

    const v2, 0x7f0f01a6

    invoke-static {v1, v2}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;I)V

    return v0

    :cond_1
    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    iget-object v1, p0, Lchat/ola/vn/transferken/b;->c:Landroid/widget/EditText;

    iget-object v2, p0, Lchat/ola/vn/transferken/b;->d:Landroid/view/animation/Animation;

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :cond_2
    :try_start_1
    invoke-static {v2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    const-wide/16 v4, 0x3e8

    cmp-long v6, v2, v4

    const/4 v7, 0x1

    if-gez v6, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/transferken/b;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object v1

    const v2, 0x7f0f0370

    new-array v3, v7, [Ljava/lang/Object;

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v0

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/transferken/b;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;Ljava/lang/String;)V

    return v0

    :cond_3
    const-wide/32 v4, 0x5f5e100

    cmp-long v6, v2, v4

    if-lez v6, :cond_4

    invoke-virtual {p0}, Lchat/ola/vn/transferken/b;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object v1

    const v2, 0x7f0f02ba

    new-array v3, v7, [Ljava/lang/Object;

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v0

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/transferken/b;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return v0

    :cond_4
    :try_start_2
    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    iget-object v1, p0, Lchat/ola/vn/transferken/b;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v2, p0, Lchat/ola/vn/transferken/b;->d:Landroid/view/animation/Animation;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    return v0

    :cond_5
    return v7

    :catch_0
    return v0
.end method


# virtual methods
.method protected b(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/transferken/a;->b(Landroid/os/Bundle;)V

    return-void
.end method

.method public c()Lchat/ola/vn/transferken/a;
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/transferken/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/transferken/c;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/transferken/c;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f04d9

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090373

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/transferken/b;->j()V

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/transferken/b;->v()Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/transferken/b;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/transferken/b;->c:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    iget-object p1, p0, Lchat/ola/vn/transferken/b;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/transferken/b;->c:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, ","

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    sput-wide v0, Lchat/ola/vn/transferken/c;->b:J

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/transferken/b;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->c(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/transferken/b$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/transferken/b$3;-><init>(Lchat/ola/vn/transferken/b;)V

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/d;)V

    :cond_2
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 3

    const p2, 0x7f0b017a

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f090535

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object p2, p0, Lchat/ola/vn/transferken/b;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const p2, 0x7f090536

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/EditText;

    iput-object p2, p0, Lchat/ola/vn/transferken/b;->c:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/transferken/b;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    sget-boolean p3, Lchat/ola/vn/c/x;->r:Z

    invoke-virtual {p2, p3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAllowedSuggestion(Z)V

    new-instance p2, Lchat/ola/vn/b/q;

    invoke-virtual {p0}, Lchat/ola/vn/transferken/b;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object p3

    invoke-direct {p2, p3}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    invoke-static {}, Lchat/ola/vn/g;->a()Ljava/util/List;

    move-result-object p3

    invoke-virtual {p2, p3}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    new-instance p3, Lchat/ola/vn/b/q$a;

    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {p3, p2}, Lchat/ola/vn/b/q$a;-><init>(Lchat/ola/vn/b/q;)V

    invoke-virtual {p2, p3}, Lchat/ola/vn/b/q;->a(Landroid/widget/Filter;)V

    iget-object p3, p0, Lchat/ola/vn/transferken/b;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {p3, p2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object p2, p0, Lchat/ola/vn/transferken/b;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance p3, Lchat/ola/vn/transferken/b$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/transferken/b$1;-><init>(Lchat/ola/vn/transferken/b;)V

    invoke-virtual {p2, p3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V

    invoke-virtual {p0}, Lchat/ola/vn/transferken/b;->h()Landroid/content/Intent;

    move-result-object p2

    if-eqz p2, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/transferken/b;->h()Landroid/content/Intent;

    move-result-object p2

    const-string p3, "_buddy_id"

    invoke-virtual {p2, p3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    iget-object p3, p0, Lchat/ola/vn/transferken/b;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {p3, p2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/transferken/b;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const/4 p3, 0x0

    invoke-virtual {p2, p3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setEnabled(Z)V

    iget-object p2, p0, Lchat/ola/vn/transferken/b;->c:Landroid/widget/EditText;

    invoke-virtual {p2}, Landroid/widget/EditText;->requestFocus()Z

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/transferken/b;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object p2

    const p3, 0x7f010042

    invoke-static {p2, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/transferken/b;->d:Landroid/view/animation/Animation;

    const p2, 0x7f090534

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/transferken/b;->a:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/transferken/b;->c:Landroid/widget/EditText;

    new-instance p3, Lchat/ola/vn/transferken/b$2;

    invoke-direct {p3, p0}, Lchat/ola/vn/transferken/b$2;-><init>(Lchat/ola/vn/transferken/b;)V

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    const p2, 0x7f090373

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_1

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2}, Lchat/ola/vn/network/OlaNetworkService;->r()V

    :cond_1
    sget-wide p2, Lchat/ola/vn/h;->o:J

    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-eqz v2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/transferken/b;->a:Landroid/widget/TextView;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    sget-wide v0, Lchat/ola/vn/h;->o:J

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " KEN"

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_2
    return-object p1
.end method
