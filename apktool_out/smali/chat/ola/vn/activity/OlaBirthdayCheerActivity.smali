.class public Lchat/ola/vn/activity/OlaBirthdayCheerActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/activity/OlaBirthdayCheerActivity$a;
    }
.end annotation


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Lchat/ola/vn/b/l;

.field private g:Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->e:Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->f:Lchat/ola/vn/b/l;

    return-void
.end method

.method private B()V
    .locals 2

    const v0, 0x7f09008e

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->e:Landroid/widget/ListView;

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->g:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->g:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f064a

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void
.end method

.method private C()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->f:Lchat/ola/vn/b/l;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/b/l;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/l;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->f:Lchat/ola/vn/b/l;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->f:Lchat/ola/vn/b/l;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/l;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->f:Lchat/ola/vn/b/l;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->f:Lchat/ola/vn/b/l;

    invoke-virtual {v0}, Lchat/ola/vn/b/l;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x20000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

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

.method static synthetic b(Landroid/content/Context;)V
    .locals 0

    invoke-static {p0}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->c(Landroid/content/Context;)V

    return-void
.end method

.method private static c(Landroid/content/Context;)V
    .locals 0

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->C()V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f09008b

    const/4 v2, 0x0

    if-eq v0, v1, :cond_3

    const v1, 0x7f090247

    if-eq v0, v1, :cond_2

    const v1, 0x7f0902c5

    if-eq v0, v1, :cond_1

    const p1, 0x7f09039c

    if-eq v0, p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->onBackPressed()V

    return-void

    :cond_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->i(Ljava/lang/String;)V

    const v0, 0x7f010057

    invoke-static {p0, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    const-wide/16 v1, 0x96

    invoke-virtual {v0, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-virtual {p1, v0}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    return-void

    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1, v2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    new-instance v1, Lchat/ola/vn/activity/OlaBirthdayCheerActivity$a;

    invoke-direct {v1, p0, v2}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity$a;-><init>(Lchat/ola/vn/activity/OlaBirthdayCheerActivity;Lchat/ola/vn/activity/OlaBirthdayCheerActivity$1;)V

    invoke-static {p0, v0, p1, v1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Lchat/ola/vn/entity/n;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b013d

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->B()V

    return-void
.end method
