.class Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

.field private b:Landroid/view/View;

.field private c:Ljava/lang/String;

.field private d:Lchat/ola/vn/view/OlaCachedImageView;

.field private e:Landroid/widget/TextView;


# direct methods
.method private constructor <init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;-><init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;)V

    return-void
.end method

.method private a()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->d:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->c:Ljava/lang/String;

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->d:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method


# virtual methods
.method public a(Landroid/view/View;)V
    .locals 1

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->b:Landroid/view/View;

    const v0, 0x7f090270

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->d:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f090570

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->e:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->b:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->c:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->a()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->e:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
