.class public Lchat/ola/vn/g/g;
.super Lchat/ola/vn/g/a;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/g/a;-><init>()V

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/g/g;->a:I

    return-void
.end method


# virtual methods
.method public a(Landroid/view/LayoutInflater;)Landroid/view/View;
    .locals 2

    const v0, 0x7f0b007b

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public a(Landroid/view/View;Lchat/ola/vn/g/h;)Lchat/ola/vn/g/h;
    .locals 1

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/g/g;->c:Z

    iput-boolean v0, p2, Lchat/ola/vn/g/h;->b:Z

    iget-boolean v0, p0, Lchat/ola/vn/g/g;->b:Z

    iput-boolean v0, p2, Lchat/ola/vn/g/h;->a:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    new-instance p2, Lchat/ola/vn/g/n;

    invoke-direct {p2, p1}, Lchat/ola/vn/g/n;-><init>(Landroid/view/View;)V

    iget-boolean p1, p0, Lchat/ola/vn/g/g;->c:Z

    iput-boolean p1, p2, Lchat/ola/vn/g/n;->b:Z

    iget-boolean p1, p0, Lchat/ola/vn/g/g;->b:Z

    iput-boolean p1, p2, Lchat/ola/vn/g/n;->a:Z

    return-object p2
.end method

.method public b(Landroid/content/Context;Landroid/view/View;IJ)V
    .locals 0

    invoke-static {p1}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->a(Landroid/content/Context;)V

    return-void
.end method
