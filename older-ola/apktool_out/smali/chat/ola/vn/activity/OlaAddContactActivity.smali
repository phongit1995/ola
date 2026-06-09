.class public Lchat/ola/vn/activity/OlaAddContactActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/p/i;


# instance fields
.field private e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field private f:Lchat/ola/vn/b/q;

.field private g:Landroid/view/View;

.field private h:Landroid/view/View;

.field private i:Landroid/widget/Button;

.field private j:Landroid/widget/TextView;

.field private k:Landroid/widget/TextView;

.field private l:Lchat/ola/vn/view/OlaCachedImageView;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private B()V
    .locals 2

    const v0, 0x7f0901bf

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->h:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->h:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->h:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09030a

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const v0, 0x7f090254

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const v0, 0x7f090031

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903c3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f090570

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->k:Landroid/widget/TextView;

    const v0, 0x7f090270

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->l:Lchat/ola/vn/view/OlaCachedImageView;

    return-void
.end method

.method private C()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->h:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v1, 0x0

    :try_start_1
    sget-object v2, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v2, v2, Lchat/ola/vn/entity/ag;->x:Z

    if-eqz v2, :cond_0

    invoke-static {v0}, Lchat/ola/vn/util/m;->t(Ljava/lang/String;)Z

    move-result v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    :cond_0
    const/4 v2, 0x0

    :goto_0
    const/4 v3, 0x1

    if-eqz v2, :cond_1

    :try_start_2
    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaAddContactActivity;->c(Z)V

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-array v3, v3, [Ljava/lang/String;

    const-string v4, "name"

    aput-object v4, v3, v1

    new-instance v1, Lchat/ola/vn/activity/OlaAddContactActivity$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaAddContactActivity$3;-><init>(Lchat/ola/vn/activity/OlaAddContactActivity;)V

    invoke-virtual {v2, v0, v3, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Ljava/lang/String;Lchat/ola/vn/p/d;)V

    return-void

    :cond_1
    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaAddContactActivity;->c(Z)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, v0, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/i;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaAddContactActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const v0, 0x7f010038

    const v1, 0x7f010039

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaAddContactActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAddContactActivity;->C()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaAddContactActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/activity/OlaAddContactActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaAddContactActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaAddContactActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->g:Landroid/view/View;

    return-object p0
.end method

.method private f(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->h:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setVisibility(I)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->c(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    const v0, 0x7f080128

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    const v0, 0x7f0f0550

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->C:I

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    const v0, 0x7f080626

    :goto_0
    invoke-virtual {p1, v0, v1, v1, v1}, Landroid/widget/Button;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    const v0, 0x7f08011a

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    const v0, 0x7f0f041e

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->z:I

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->i:Landroid/widget/Button;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v0, 0x7f08069a

    goto :goto_0

    :catch_0
    return-void
.end method

.method private f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->h:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->k:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->j:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->j:Landroid/widget/TextView;

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->j:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->l:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p2, p1, v1, v0}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->f(Ljava/lang/String;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-static {p0, p1, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Z)V
    .locals 1

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaAddContactActivity;->c(Z)V

    if-eqz p2, :cond_0

    const/4 p2, 0x0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/activity/OlaAddContactActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->selectAll()V

    const p1, 0x7f0f00a2

    const p2, 0x7f0f0443

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c(Z)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->g:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->g:Landroid/view/View;

    new-instance v0, Lchat/ola/vn/activity/OlaAddContactActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaAddContactActivity$4;-><init>(Lchat/ola/vn/activity/OlaAddContactActivity;)V

    const-wide/32 v1, 0xea60

    invoke-virtual {p1, v0, v1, v2}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaAddContactActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f090031

    if-eq v0, v1, :cond_3

    const v1, 0x7f0901bf

    if-eq v0, v1, :cond_2

    const p1, 0x7f09039c

    if-eq v0, p1, :cond_1

    const p1, 0x7f0903be

    if-eq v0, p1, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAddContactActivity;->C()V

    return-void

    :cond_1
    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAddContactActivity;->finish()V

    return-void

    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-static {p0, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_4

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_4
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0130

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->setContentView(I)V

    const p1, 0x7f0903ea

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->g:Landroid/view/View;

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const v0, 0x7f0f040d

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const v0, 0x7f0f044d

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903a4

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090452

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean p1, p1, Lchat/ola/vn/entity/ag;->x:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const v0, 0x7f0f04dc

    :goto_0
    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setHint(I)V

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v0, 0x7f0f04da

    goto :goto_0

    :catch_0
    :goto_1
    const p1, 0x7f0903be

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v0, Lchat/ola/vn/activity/OlaAddContactActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaAddContactActivity$1;-><init>(Lchat/ola/vn/activity/OlaAddContactActivity;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v0, Lchat/ola/vn/activity/OlaAddContactActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaAddContactActivity$2;-><init>(Lchat/ola/vn/activity/OlaAddContactActivity;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V

    new-instance p1, Lchat/ola/vn/b/q;

    invoke-direct {p1, p0}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->f:Lchat/ola/vn/b/q;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->f:Lchat/ola/vn/b/q;

    new-instance v0, Lchat/ola/vn/b/q$a;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->f:Lchat/ola/vn/b/q;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {v0, v1}, Lchat/ola/vn/b/q$a;-><init>(Lchat/ola/vn/b/q;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/q;->a(Landroid/widget/Filter;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity;->f:Lchat/ola/vn/b/q;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAddContactActivity;->B()V

    return-void
.end method
