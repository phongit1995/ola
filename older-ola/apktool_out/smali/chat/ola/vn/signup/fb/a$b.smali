.class Lchat/ola/vn/signup/fb/a$b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/signup/fb/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/fb/a;

.field private b:Ljava/lang/String;


# direct methods
.method private constructor <init>(Lchat/ola/vn/signup/fb/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/a$b;->a:Lchat/ola/vn/signup/fb/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/signup/fb/a;Lchat/ola/vn/signup/fb/a$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/signup/fb/a$b;-><init>(Lchat/ola/vn/signup/fb/a;)V

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a$b;->b:Ljava/lang/String;

    return-object v0
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/a$b;->b:Ljava/lang/String;

    return-void
.end method
