.class public Lchat/ola/vn/b/d;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/maps/GoogleMap$InfoWindowAdapter;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/d$a;
    }
.end annotation


# instance fields
.field private a:Landroid/content/Context;

.field private b:Lchat/ola/vn/b/d$a;

.field private c:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/view/View$OnClickListener;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/b/d;->c:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/b/d;->a:Landroid/content/Context;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/d;)Lchat/ola/vn/b/d$a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/d;->b:Lchat/ola/vn/b/d$a;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/b/d;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/d;->c:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic b(Lchat/ola/vn/b/d;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/d;->c:Ljava/lang/String;

    return-object p0
.end method


# virtual methods
.method public getInfoContents(Lcom/google/android/gms/maps/model/Marker;)Landroid/view/View;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public getInfoWindow(Lcom/google/android/gms/maps/model/Marker;)Landroid/view/View;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/d;->b:Lchat/ola/vn/b/d$a;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/b/d$a;

    iget-object v1, p0, Lchat/ola/vn/b/d;->a:Landroid/content/Context;

    invoke-direct {v0, p0, v1}, Lchat/ola/vn/b/d$a;-><init>(Lchat/ola/vn/b/d;Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/b/d;->b:Lchat/ola/vn/b/d$a;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/d;->b:Lchat/ola/vn/b/d$a;

    iput-object p1, v0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    iget-object p1, p0, Lchat/ola/vn/b/d;->b:Lchat/ola/vn/b/d$a;

    invoke-static {p1}, Lchat/ola/vn/b/d$a;->a(Lchat/ola/vn/b/d$a;)V

    iget-object p1, p0, Lchat/ola/vn/b/d;->b:Lchat/ola/vn/b/d$a;

    return-object p1
.end method
