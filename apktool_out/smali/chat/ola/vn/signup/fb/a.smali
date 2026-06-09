.class public Lchat/ola/vn/signup/fb/a;
.super Lchat/ola/vn/signup/fb/b;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/signup/fb/a$a;,
        Lchat/ola/vn/signup/fb/a$c;,
        Lchat/ola/vn/signup/fb/a$b;
    }
.end annotation


# instance fields
.field private a:Landroid/widget/ListView;

.field private b:Landroid/view/View;

.field private c:Lchat/ola/vn/signup/fb/a$a;

.field private d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/signup/fb/a$b;",
            ">;"
        }
    .end annotation
.end field

.field private e:Ljava/lang/String;

.field private f:Lchat/ola/vn/network/c;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/signup/fb/b;-><init>()V

    new-instance v0, Lchat/ola/vn/signup/fb/a$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/signup/fb/a$1;-><init>(Lchat/ola/vn/signup/fb/a;)V

    iput-object v0, p0, Lchat/ola/vn/signup/fb/a;->f:Lchat/ola/vn/network/c;

    return-void
.end method

.method private a(Landroid/view/View;)V
    .locals 1

    const v0, 0x7f090112

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903e9

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/signup/fb/a;->b:Landroid/view/View;

    const v0, 0x7f09031c

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ListView;

    iput-object p1, p0, Lchat/ola/vn/signup/fb/a;->a:Landroid/widget/ListView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private a(Z)V
    .locals 1

    if-eqz p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/signup/fb/a;->b:Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/signup/fb/a;->b:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/16 v0, 0x8

    goto :goto_0

    :catch_0
    return-void
.end method

.method private x()V
    .locals 2

    new-instance v0, Lchat/ola/vn/signup/fb/a$a;

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/a;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lchat/ola/vn/signup/fb/a$a;-><init>(Lchat/ola/vn/signup/fb/a;Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/signup/fb/a;->c:Lchat/ola/vn/signup/fb/a$a;

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a;->c:Lchat/ola/vn/signup/fb/a$a;

    invoke-virtual {v0, p0}, Lchat/ola/vn/signup/fb/a$a;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a;->d:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a;->c:Lchat/ola/vn/signup/fb/a$a;

    iget-object v1, p0, Lchat/ola/vn/signup/fb/a;->d:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/a$a;->a(Ljava/util/List;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/a;->a:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/signup/fb/a;->c:Lchat/ola/vn/signup/fb/a$a;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    return-void
.end method


# virtual methods
.method public c()Lchat/ola/vn/signup/fb/b;
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/signup/fb/c;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/signup/fb/b;

    iget-object v1, p0, Lchat/ola/vn/signup/fb/a;->e:Ljava/lang/String;

    sput-object v1, Lchat/ola/vn/signup/fb/d;->a:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f053d

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f090112

    if-eq v0, v1, :cond_1

    const v1, 0x7f090270

    if-eq v0, v1, :cond_0

    const v1, 0x7f090570

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/signup/fb/a;->a(Z)V

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/signup/fb/a$b;

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a;->e:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/a$b;->a()Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/signup/fb/a;->f:Lchat/ola/vn/network/c;

    invoke-static {v0, p1, v1}, Lchat/ola/vn/l/b;->d(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/c;)V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/a;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/signup/fb/b;->onCreate(Landroid/os/Bundle;)V

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/a;->getArguments()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "_trust_token"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/signup/fb/a;->e:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/a;->getArguments()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "_byte_data"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getStringArray(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/signup/fb/a;->d:Ljava/util/List;

    const/4 v0, 0x0

    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_0

    new-instance v1, Lchat/ola/vn/signup/fb/a$b;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lchat/ola/vn/signup/fb/a$b;-><init>(Lchat/ola/vn/signup/fb/a;Lchat/ola/vn/signup/fb/a$1;)V

    aget-object v2, p1, v0

    invoke-virtual {v1, v2}, Lchat/ola/vn/signup/fb/a$b;->a(Ljava/lang/String;)V

    iget-object v2, p0, Lchat/ola/vn/signup/fb/a;->d:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/signup/fb/a;->c:Lchat/ola/vn/signup/fb/a$a;

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a;->d:Ljava/util/List;

    invoke-virtual {p1, v0}, Lchat/ola/vn/signup/fb/a$a;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/a;->c:Lchat/ola/vn/signup/fb/a$a;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/a$a;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    const p2, 0x7f0b00a2

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/signup/fb/a;->a(Landroid/view/View;)V

    invoke-direct {p0}, Lchat/ola/vn/signup/fb/a;->x()V

    return-object p1
.end method
