.class Lchat/ola/vn/signup/OlaSignUpActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/OlaSignUpActivity;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:[B

.field final synthetic d:[Lchat/ola/vn/entity/d;

.field final synthetic e:S

.field final synthetic f:Lchat/ola/vn/signup/OlaSignUpActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/OlaSignUpActivity;ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1;->f:Lchat/ola/vn/signup/OlaSignUpActivity;

    iput p2, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1;->a:I

    iput-object p3, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1;->c:[B

    iput-object p5, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1;->d:[Lchat/ola/vn/entity/d;

    iput-short p6, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1;->e:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1;->f:Lchat/ola/vn/signup/OlaSignUpActivity;

    invoke-virtual {v0}, Lchat/ola/vn/signup/OlaSignUpActivity;->C()Lchat/ola/vn/signup/a;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/signup/OlaSignUpActivity$1$1;

    invoke-direct {v1, p0, v0}, Lchat/ola/vn/signup/OlaSignUpActivity$1$1;-><init>(Lchat/ola/vn/signup/OlaSignUpActivity$1;Lchat/ola/vn/signup/a;)V

    const-wide/16 v2, 0x3e8

    invoke-static {v1, v2, v3}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
