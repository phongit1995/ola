.class Lchat/ola/vn/signup/OlaSignUpActivity$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/OlaSignUpActivity$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/a;

.field final synthetic b:Lchat/ola/vn/signup/OlaSignUpActivity$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/OlaSignUpActivity$1;Lchat/ola/vn/signup/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1$1;->b:Lchat/ola/vn/signup/OlaSignUpActivity$1;

    iput-object p2, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1$1;->a:Lchat/ola/vn/signup/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1$1;->a:Lchat/ola/vn/signup/a;

    iget-object v1, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1$1;->b:Lchat/ola/vn/signup/OlaSignUpActivity$1;

    iget v1, v1, Lchat/ola/vn/signup/OlaSignUpActivity$1;->a:I

    iget-object v2, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1$1;->b:Lchat/ola/vn/signup/OlaSignUpActivity$1;

    iget-object v2, v2, Lchat/ola/vn/signup/OlaSignUpActivity$1;->b:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1$1;->b:Lchat/ola/vn/signup/OlaSignUpActivity$1;

    iget-object v3, v3, Lchat/ola/vn/signup/OlaSignUpActivity$1;->c:[B

    iget-object v4, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1$1;->b:Lchat/ola/vn/signup/OlaSignUpActivity$1;

    iget-object v4, v4, Lchat/ola/vn/signup/OlaSignUpActivity$1;->d:[Lchat/ola/vn/entity/d;

    iget-object v5, p0, Lchat/ola/vn/signup/OlaSignUpActivity$1$1;->b:Lchat/ola/vn/signup/OlaSignUpActivity$1;

    iget-short v5, v5, Lchat/ola/vn/signup/OlaSignUpActivity$1;->e:S

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/signup/a;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
